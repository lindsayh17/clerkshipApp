//  EvaluationView.swift
//  clerkshipApp

/*
 TODO: pull questions from firebase
 TODO: 3 different form types
 TODO: link student, preceptor, form type ids to firebase write
 TODO: get his sample form questions/include images
 TODO: display a list of completed evaluations somewhere for the preceptors
 
 */

import SwiftUI

struct EvaluationView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    @State private var form = Form()
    @State private var submitted = false
    
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
    
    // Submit form data to Firestore
    func submitForm() {
        let responses = form.questions.compactMap { question -> Response? in
            guard let responseText = question.responseString else { return nil }
            return Response(questionId: question.id.uuidString, answer: responseText)
        }
        
        let evaluation = Evaluation(
            formId: "historyGathering",
            preceptorId: currUser.user?.firebaseID ?? "0",
            studentId: "2",
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
                            // Assesment description
                            Group {
                                Text("**Novice:** Gathers too little or too much info, does not link info in a clinically relevant fashion, communication is not patient-focused, uses same broad template for all interactions.")
                                Text("**Apprentice:** Gathers most relevant info, links most findings in a clinically relevant way, communication is mostly patient-focused but occasionally unidirectional, tailors history to specific encounters.")
                                Text("**Expert:** Gathers complete and accurate history appropriate to the situation, demonstrates clinical reasoning useful in patient care, communication is bidirectional and patient-family centered, adapts history to multiple clinical settings (acute, chronic, inpatient, outpatient).")
                            }
                            .font(.caption2)
                            .foregroundColor(.white)
                            .lineSpacing(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        
                            // Header Row
                            HStack {
                                Text("Question")
                                    .foregroundColor(.white)
                                    .frame(width: 70, alignment: .leading)
                                Spacer()
                                ForEach(["Unable to Assess", "Novice", "Advanced Novice", "Apprentice", "Competent", "Expert"], id: \.self) { label in
                                   Text(label)
                                       .foregroundColor(.white)
                                       .frame(maxWidth: .infinity)
                               }
                            }
                            .font(.caption)
                            .padding(.bottom, 3)
                            Divider().background(Color.gray)
                            
                            // Question Rows
                            ForEach($form.questions) { $q in
                                if q.type == .radio {
                                    HStack(alignment: .center, spacing: 12) {
                                        Text(q.question)
                                            .foregroundColor(.white)
                                            .frame(width: 70, alignment: .leading)
                                            .font(.caption2)
                                            .fixedSize(horizontal: false, vertical: true)
                                        
                                        Spacer()
                                        
                                        ForEach(["Unable to Assess", "Novice", "Advanced Novice", "Apprentice", "Competent", "Expert"], id: \.self) { option in
                                            Button(action: {
                                                q.response = .text(option)
                                            }) {
                                                Image(systemName: q.responseString == option ? "circle.inset.filled" : "circle")
                                                    .foregroundColor(q.responseString == option ? .purple : .white)
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    Divider().background(Color.gray)
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
