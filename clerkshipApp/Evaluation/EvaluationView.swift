//  EvaluationView.swift
//  clerkshipApp

/*
 TODO: pull questions from firebase
 TODO: link student, preceptor, form type ids to firebase write
 TODO: display a list of completed evaluations somewhere for the preceptors
 
 */

import SwiftUI

enum OptionDefinition {
    case novice
    case apprentice
    case expert
    case none
}

struct EvaluationView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    @State private var form = Form()
    @State private var submitted = false
    
    @State private var showInfo = false
    @State private var selection: OptionDefinition = .none
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // TODO: display this somewhere
    let currStudent: User
    
    // Firebase download (if needed)
    func download() {
        Task {
            do {
                try await firebase.fetchForms()
            }
        }
    }
    
    private func infoBlurb(for opt: OptionDefinition) -> String {
        switch opt {
        case .novice:
            return "Gathers too little or too much info, does not link info in a clinically relevant fashion, communication is not patient-focused, uses same broad template for all interactions."
        case .apprentice: 
            return "Gathers most relevant info, links most findings in a clinically relevant way, communication is mostly patient-focused but occasionally unidirectional, tailors history to specific encounters."
        case .expert:
            return "Gathers complete and accurate history appropriate to the situation, demonstrates clinical reasoning useful in patient care, communication is bidirectional and patient-family centered, adapts history to multiple clinical settings (acute, chronic, inpatient, outpatient)."
        case .none: 
            return ""
        }
    }
    
    private func infoTitle(for opt: OptionDefinition) -> String {
        switch opt {
        case .novice: return "Novice"
        case .apprentice: return "Apprentice"
        case .expert: return "Expert"
        case .none: return "None"
        }
    }
    
    private func headerItem(title: String, option: OptionDefinition) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Button {
                selection = option
                showInfo = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .baselineOffset(1)
                    .font(.system(size: 12))
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
    
    private func labelledRow() -> some View {
        // labelled row
        HStack {
            Group {
                Text("N/A").foregroundColor(.white).padding()
                headerItem(title: "Novice", option: .novice)
                headerItem(title: "Apprentice", option: .apprentice)
                headerItem(title: "Expert", option: .expert)
            }.alert(infoTitle(for: selection), isPresented: $showInfo) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(infoBlurb(for: selection))
            }
        }
    }
    
    // Submit form data to Firestore
    func submitForm() {
        let responses = form.questions.compactMap { question -> Response? in
            guard let responseText = question.responseString else { return nil }
            return Response(questionId: question.id.uuidString, answer: responseText)
        }
        
        let evaluation = Evaluation(
            formId: "historyGathering",
            preceptorId: currUser.user?.firebaseID ?? "0",
            studentId: currStudent.firebaseID,
            responses: responses,
            submittedAt: Date()
        )
        
        evalStore.add(evaluation: evaluation)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            // Title
                            Text("History Gathering Evaluation")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 6)
                            labelledRow()
                                Divider().background(Color.gray)
                                
                                
                                // Question Rows
                                ForEach($form.questions) { $q in
                                    if q.type == .radio {
                                        VStack {
                                            Text(q.question)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .fixedSize(horizontal: false, vertical: true)
                                            
                                            HStack(alignment: .center, spacing: 12) {
                                                
                                                ForEach(["N/A", "Novice", "Apprentice", "Expert"], id: \.self) { option in
                                                    Button(action: {
                                                        q.response = .text(option)
                                                    }) {
                                                        Image(systemName: q.responseString == option ? "circle.inset.filled" : "circle")
                                                            .foregroundColor(q.responseString == option ? .purple : .white)
                                                    }
                                                    .frame(maxWidth: .infinity)
                                                }.padding(.vertical, 8)
                                            }
                                            Divider().background(Color.gray)
                                        }
                                    }
                                    
                                    
                                    // Notes Field
                                    if q.type == .open {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(q.question)
                                                .foregroundColor(.white)
                                            TextEditor(
                                                text: Binding(
                                                    get: {
                                                        if case .text(let notes) = q.response { return notes }
                                                        return ""
                                                    },
                                                    set: { q.response = .text($0) }
                                                )
                                            )
                                            .frame(height: 80)
                                            .padding(8)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                
                                // Submit Button
                                Button(action: {
                                    submitted = true
                                    submitForm()
                                }) {
                                    Text("Submit Form")
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(form.validForm() ? buttonColor : Color.gray)
                                        .cornerRadius(30)
                                }
                                .disabled(!form.validForm())
                                .padding(.top, 20)
                            }
                            .padding()
                        }
                    }
                    .navigationDestination(isPresented: $submitted) {
                        SubmittedView()
                    }
            }
        }
    }
}

// Add if there is if you get here on a student view, put a question at the bottom where you have to put in preceptor email

//
// Radio Button
//
struct RadioButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .foregroundColor(isSelected ? .purple : .white)
                Text(label)
                    .foregroundColor(.white)
            }
        }
    }
}


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

// Preview
#Preview {
    EvaluationView(currStudent: User(firstName: "Place", lastName: "Holder", email: "email"))
        .environmentObject(FirebaseService())
        .environmentObject(EvalStore())
        .environmentObject(CurrentUser())
}
