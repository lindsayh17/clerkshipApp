//  EvaluationView.swift
//  clerkshipApp

import SwiftUI

struct EvaluationView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    
    @State var addedNotes = ""
    @State var explainAlert = false
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
                return (!preceptorEmail.trimmingCharacters(in: .whitespaces).isEmpty && formState.validForm())
            }
        }
        
        return false
    }
    
    // Submit form data to Firestore
    func submitForm() {
        var responseDict: [String: [String: String]] = [:]
        for category in formState.data.categories {
            for question in category.questions {
                let response = formState.responses[question.question] ?? .none
                if responseDict[category.category] == nil{
                    responseDict[category.category] = [:]
                }
                responseDict[category.category]?[question.question] = infoTitle(for: response)
            }
        }
        
        let evaluation = Evaluation(
            formType: formState.data.type,
            preceptorId: currUser.user?.id ?? "0",
            studentId: currStudent.id ?? "1",
            responses: responseDict,
            submittedAt: Date(),
            notes: addedNotes
        )
        
        evalStore.addToFirestore(evaluation: evaluation)
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
                    .multilineTextAlignment(.center)
                
                if let curr = currUser.user{
                    if curr.access == .preceptor{
                        Text("Student Name: \(currStudent.firstName) \(currStudent.lastName) (\(currStudent.email))")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Divider().background(.gray)
                    
                ScrollView {
                    ForEach (formState.data.categories) { cat in
                        CategoryView(category: cat, formState: formState)
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
                            HStack {
                                Text("Preceptor Email")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                if !canSubmit() {
                                    Button {
                                        explainAlert.toggle()
                                    } label: {
                                        Image(systemName: "exclamationmark.circle")
                                            .foregroundColor(.red)
                                            .baselineOffset(2)
                                            .font(.system(size: 14))
                                    }
                                }
                            }
                            TextField("Enter preceptor email", text: $preceptorEmail)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .stroke(preceptorEmail == "" ? .red.opacity(0.5) : .white, lineWidth: 5)
                                )
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
    
    private func infoTitle(for opt: ResponseLabel) -> String {
        switch opt {
        case .novice: return "Novice"
        case .apprentice: return "Apprentice"
        case .expert: return "Expert"
        case .none: return "N/A"
        }
    }
    
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
                        formState.responses[question.question] = opt
                    }) {
                        VStack {
                            Image(systemName: formState.responses[question.question] == opt ? "circle.inset.filled" : "circle")
                                .foregroundColor(formState.responses[question.question] == opt ? buttonColor : .white)
                                .buttonStyle(BorderlessButtonStyle())
                                .frame(maxWidth: .infinity)
                            
                            Text(infoTitle(for: opt))
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                        }
                    }
                }
            }.padding(.vertical, 4)
            
            Divider().background(Color.gray)
        }
    }
}

struct CategoryView: View {
    @ObservedObject var category: QuestionCategory
    @StateObject var formState: EvalFormState
    @State private var showMoreInfo = false
    
    private let buttonColor = Color("ButtonColor")

    
    var body: some View {
        Group {
            HStack {
                Text(category.category)
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)
                
                Button {
                    showMoreInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .baselineOffset(2)
                        .font(.system(size: 12))
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            
            VStack {
                ForEach (category.questions) { q in
                    QuestionRowView(question: q, formState: formState)
                }
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 10)
        }.padding(.horizontal)
            
//            Button {
//                // next category
//            } label: {
//                Text("Next")
//                    .fontWeight(.semibold)
//                    .frame(width: 100, height: 50)
//                    .background(buttonColor)
//                    .foregroundColor(.white)
//                    .cornerRadius(20)
//                    .padding()
//            }
        
            // show rubric menu
            .sheet(isPresented: $showMoreInfo) {
                InfoBlurbView(category: category.category)
                    .presentationDetents([.fraction(0.9)])
                    .presentationCornerRadius(50)
                    .presentationBackground(.thinMaterial)
        }
    }
}

struct InfoBlurbView: View {
    var category: String
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    
    // Hardcoded values for now, could eventually grab from firebase
    private let quickFacts: [QuickFactItem] = [
        QuickFactItem(title: "Novice",
                      description: "\u{2022} Gathers too little or too much info\n\u{2022} Does not link info in a clinically relevant fashion\n\u{2022} Communication is not patient-focused\n\u{2022} Uses same broad template for all interactions."),
        QuickFactItem(title: "Apprentice",
                      description: "\u{2022} Gathers most relevant info \n\u{2022} Links most findings in a clinically relevant way \n\u{2022} Communication is mostly patient-focused but occasionally unidirectional \n\u{2022} Tailors history to specific encounters."),
        QuickFactItem(title: "Expert",
                     description: "\u{2022} Gathers complete and accurate history appropriate to the situation \n\u{2022} Demonstrates clinical reasoning useful in patient care \n\u{2022} Communication is bidirectional and patient-family centered \n\u{2022} Adapts history to multiple clinical settings (acute, chronic, inpatient, outpatient)."),
        ]
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("\(category) Rubric")
                        .foregroundColor(.white.opacity(0.9))
                        .fontWeight(.bold)
                    
                    ForEach(quickFacts) { item in
                    
                        VStack(alignment: .leading, spacing: 8) {
                            // Header Row
                            HStack {
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            // Description
                            Text(item.description)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 12)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 10)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                buttonColor.opacity(0.9), backgroundColor]), startPoint: .topTrailing, endPoint: .bottom)
        )
    }
}

#Preview {
    EvaluationView(
        formState: EvalFormState(
            data: EvalForm(
                categories: [
                    QuestionCategory(
                        category: "Category of Question",
                        questions: [
                            Question(question: "Skill level"),
                            Question(question: "Experience level")
                        ]
                    ),
                    QuestionCategory(
                        category: "Second Category",
                        questions: [
                            Question(question: "Ability"),
                            Question(question: "Another question")
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
