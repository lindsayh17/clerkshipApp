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
            preceptorId: currUser.user?.id ?? "0",
            studentId: currStudent.id ?? "1",
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
                    .multilineTextAlignment(.center)
                
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
                            .multilineTextAlignment(.center)
                    }.frame(maxWidth: .infinity)
                }
                Divider().background(Color.gray)
                    
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
                    .padding(.top, 6)
                    .multilineTextAlignment(.center)
                
                Button {
                    showMoreInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .baselineOffset(1)
                        .font(.system(size: 12))
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            
            ForEach (category.questions) { q in
                QuestionRowView(question: q, formState: formState)
            }
            
            Button {
                // next category
            } label: {
                Text("Next")
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 50)
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding()
            }
        }
        .sheet(isPresented: $showMoreInfo) {
            InfoBlurbView()
                .presentationDetents([.fraction(0.5)])
                .presentationCornerRadius(50)
                .presentationBackground(.thinMaterial)
        }
    }
}

struct InfoBlurbView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    // Dropdown state
    @State private var openItem: UUID? = nil
    
    @Environment(\.dismiss) var dismiss
    
    // Hardcoded values for now, could eventually grab from firebase
    private let quickFacts: [QuickFactItem] = [
        QuickFactItem(title: "Novice",
                      description: "Gathers too little or too much info, does not link info in a clinically relevant fashion, communication is not patient-focused, uses same broad template for all interactions."),
        QuickFactItem(title: "Apprentice",
                      description: "Gathers most relevant info, links most findings in a clinically relevant way, communication is mostly patient-focused but occasionally unidirectional, tailors history to specific encounters."),
        QuickFactItem(title: "Expert",
                     description: "Gathers complete and accurate history appropriate to the situation, demonstrates clinical reasoning useful in patient care, communication is bidirectional and patient-family centered, adapts history to multiple clinical settings (acute, chronic, inpatient, outpatient)."),
        ]
    
    var body: some View {
        ZStack {
            backgroundColor.opacity(0.9).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Category rubrics")
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
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.7))
                                    .rotationEffect(.degrees(openItem == item.id ? 90 : 0))
                                    .animation(.easeInOut, value: openItem == item.id)
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    openItem = (openItem == item.id ? nil : item.id)
                                }
                            }
                            
                            // Expanded description
                            if openItem == item.id {
                                Text(item.description)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 12)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 30)
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
                            Question(question: "Skill level"),
                            Question(question: "Experience level")
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
