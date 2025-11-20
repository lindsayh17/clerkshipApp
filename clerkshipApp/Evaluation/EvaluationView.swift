//  EvaluationView.swift
//  clerkshipApp

import SwiftUI

struct EvaluationView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    
    @State var addedNotes = ""
    @State var showLabels = false
    @State private var submitted = false
    
    @StateObject var formState: EvalFormState
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
    
    func canSubmit() -> Bool{
        if let curr = currUser.user{
            print("Checking submit")
            if curr.access == .preceptor {
                return formState.validForm()
            }
            
            if curr.access == .student {
                return !preceptorEmail.trimmingCharacters(in: .whitespaces).isEmpty
            }
        }
        
        return false
    }
    
    // Submit form data to Firestore
    func submitForm() {
        var responseDict: [String: String] = [:]
        for category in formState.data.categories {
            for question in category.questions {
                let response = formState.responses[question.id] ?? .none
                responseDict[question.id.uuidString] = infoTitle(for: response)
            }
        }
        
        let evaluation = Evaluation(
            formId: formState.data.id.uuidString,
            preceptorId: currUser.user?.firebaseID ?? "0",
            studentId: currStudent.firebaseID,
            responses: responseDict,
            submittedAt: Date(),
            notes: formState.notes
        )
        
        evalStore.add(evaluation: evaluation)
        submitted = true
    }
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            VStack {
                // Title
                Text("\(formState.data.type)\n Evaluation")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                
                if let curr = currUser.user{
                    if curr.access == .preceptor{
                        Text("Student Name: \(currStudent.firstName) \(currStudent.lastName) (\(currStudent.email))")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
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
                    ForEach (formState.data.categories) { cat in
                        
                        Text(cat.category)
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 6)
                        
                        ForEach (cat.questions) { q in
                            QuestionRowView(question: q, formState: formState)
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
                    if let user = currUser.user, user.access == .student {
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
                                canSubmit()
                                ? buttonColor : Color.gray
                            )
                            .cornerRadius(10)
                            .lineLimit(nil)
                            .frame(maxWidth: .infinity, minHeight: 20)
                            .padding()
                    }
                    .disabled(!canSubmit())
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
    @ObservedObject var formState: EvalFormState
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
                        formState.responses[question.id] = opt
                    }) {
                        Image(systemName: formState.responses[question.id] == opt ? "circle.inset.filled" : "circle")
                            .foregroundColor(formState.responses[question.id] == opt ? buttonColor : .white)
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(maxWidth: .infinity)
                    }
                }
            }.padding(.vertical, 4)
            
            Divider().background(Color.gray)
        }
    }
}

#Preview {
    EvaluationView(
        formState: EvalFormState(
            data: EvalForm(
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
            )
        ),
        currStudent: User(firstName: "Place", lastName: "Holder", email: "email")
    )
        .environmentObject(EvalStore())
        .environmentObject(CurrentUser())
}
