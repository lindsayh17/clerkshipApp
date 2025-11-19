//  EvaluationView.swift
//  clerkshipApp

import SwiftUI

struct FillOutFormView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    
    @State var addedNotes = ""
    @State var showLabels = false
    @State private var submitted = false
    
    @State var currForm: EvalForm
    let currStudent: User
    
    // For if a student pulls the form up
    @State private var preceptorEmail: String = ""
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")

    
    private func infoTitle(for opt: ResponseLabel) -> String {
        switch opt {
        case .novice: return "Novice"
        case .apprentice: return "Apprentice"
        case .expert: return "Expert"
        case .none: return "N/A"
        }
    }
    
    // Submit form data to Firestore
    func submitForm() {
        var responseDict: [String: String] = [:]
        for category in currForm.categories {
            for question in category.questions {
                responseDict[question.id.uuidString] = infoTitle(for: question.response ?? .none)
            }
        }
        
        let evaluation = Evaluation(
            formId: currForm.id.uuidString,
            preceptorId: currUser.user?.firebaseID ?? "0",
            studentId: currStudent.firebaseID,
            responses: responseDict,
            submittedAt: Date(),
            notes: addedNotes
        )
        
        evalStore.add(evaluation: evaluation)
        submitted = true
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            VStack {
                // Title
                Text("\(currForm.type) Evaluation\n")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                
                // button labels at the top
                HStack {
                    ForEach(ResponseLabel.allCases, id: \.self) { opt in
                        Text(infoTitle(for: opt))
                            .foregroundColor(.white)
                            .baselineOffset(1)
                            .font(.system(size: 12))
                    }.frame(maxWidth: .infinity)
                }
                Divider().background(Color.gray)
                
                ScrollView {
                    ForEach (currForm.categories) { cat in
                        
                        Text(cat.category)
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 6)
                        
                        ForEach (cat.questions) { q in
                            QuestionRowView(question: q)
                        }
                    }
                
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Notes: ")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 6)
                        
                        TextEditor(
                            text: $addedNotes
                        )
                        .frame(height: 80)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(10)
                    }.padding()
                    
                    // Student-only preceptor email field
                    if currUser.user?.access == .student {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Preceptor Email")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            TextField("Enter preceptor email", text: $preceptorEmail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    
                    Button(action: {
                        submitForm()
                    }) {
                        Text("Submit Form")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                currForm.validForm() ||
                                (currUser.user?.access == .student &&
                                 preceptorEmail.trimmingCharacters(in: .whitespaces).isEmpty)
                                ? buttonColor : Color.gray
                            )
                            .cornerRadius(10)
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity, minHeight: 20)
                            .padding()
                    }
                    .disabled(!currForm.validForm() || (currUser.user?.access == .student && preceptorEmail.trimmingCharacters(in: .whitespaces).isEmpty)
                    )
                    .padding(.top, 20)
                }
            }
            .navigationDestination(isPresented: $submitted) { SubmittedView() }
            
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct QuestionRowView: View {
    @ObservedObject var question: Question
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        VStack {
            // show the question
            Text(question.question)
                .foregroundColor(.white)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 4)
                .padding(.horizontal, 4)
                .multilineTextAlignment(.center)
            
            HStack {
                ForEach(ResponseLabel.allCases, id: \.self) { opt in
                    
                    Button(action: {
                        question.response = opt
                    }) {
                        Image(systemName: question.response == opt ? "circle.inset.filled" : "circle")
                            .foregroundColor(question.response == opt ? buttonColor : .white)
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(maxWidth: .infinity)
                    }
                }
            }.padding(.vertical, 4)
            
            Divider().background(Color.gray)
        }
    }
}

// TODO: make submitted view nicer, and have back button go to the home page, not back to eval
// SubmittedView
struct SubmittedView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Submitted!")
            Spacer()
        }
        .padding()
    }
}


#Preview {
    FillOutFormView(
        currForm: EvalForm(
            categories: [
                QuestionCategory(
                    category: "Type of Question",
                    questions: [
                        Question(question: "Skill coding in Swift"),
                        Question(question: "Experience with debugging")
                    ]
                )
            ],
            type: "Clinic",
            formChoice: .clinic
        ),
        currStudent: User(firstName: "Place", lastName: "Holder", email: "email")
    )
        .environmentObject(EvalStore())
        .environmentObject(CurrentUser())
}
