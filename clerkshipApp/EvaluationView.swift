//  EvaluationView.swift
//  clerkshipApp

import SwiftUI
// I don't think we ned import foundation ?
import Foundation

struct EvaluationView: View {
    @EnvironmentObject var firebase: FirebaseService
    //@EnvironmentObject var evalStore: EvalStore
    // Create new evaluation
    @State private var form = Form()
    // Navigation after submission
    @State private var submitted = false
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func download() {
        Task {
            do {
                // Is there supposed to be a ? after try
                try await firebase.fetchForms()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Color fills the entire screen
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Makes scrollable
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            // Display all questions in the form
                            ForEach($form.questions) { $q in
                                if q.required {
                                    Text(q.question).foregroundColor(.white) + Text(" *").foregroundColor(.red)
                                } else {
                                    Text(q.question).foregroundColor(.white)
                                }
                                
                                switch q.type {
                                case .radio:
                                    HStack {
                                        RadioButton(label: "Yes", isSelected: (q.responseString == "Yes")) {
                                            q.response = .text("Yes")
                                        }
                                        RadioButton(label: "No", isSelected: (q.responseString == "No")) {
                                            q.response = .text("No")
                                        }
                                    }
                                case .open:
                                    VStack(alignment: .leading) {
                                        // Box for comments
                                        TextEditor(
                                            text: Binding(
                                                get: {
                                                    if case .text(let notes) = q.response {
                                                        return notes
                                                    }
                                                    return ""
                                                },
                                                set: { newVal in
                                                    q.response = .text(newVal)
                                                }
                                            )
                                        )
                                        .frame(height: 100)
                                        .padding(8)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        // Text(verifyAlphaNum(testString: notes)).foregroundColor(.red)
                                    }
                                case .slider:
                                    Text("Slide")
                                    // slider code
                                }
                            }
                            // Submit button
                            Button(action: {
                                print("Form submitted")
                                submitted = true
                                // download()
                                // evalStore.add(form: form)
                                // evalStore.saveChanges()
                            }) {
                                Text("Submit Form")
                                    .foregroundColor(.white)
                                    .padding()
                                    // Width
                                    .frame(maxWidth: .infinity)
                                    // Olive green color, grey if invalid
                                    .background(form.validForm() ? buttonColor : Color.gray)
                                    .cornerRadius(30)
                            }
                            .disabled(!form.validForm())
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    NavView()
                }
                .navigationDestination(isPresented: $submitted) {
                    // Page after submitting
                    SubmittedView()
                        .onAppear() { }
                }
            }
        }
    }
}

// RadioButton Subview
struct RadioButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // Filled or empty circle based on selection
                Image(systemName: isSelected ? "circle.inset.filled" : "circle")
                    .foregroundColor(.white)
                Text(label)
                    .foregroundColor(.white)
            }
        }
    }
}

// SubmittedView Subview
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
    EvaluationView().environmentObject(FirebaseService())
}
