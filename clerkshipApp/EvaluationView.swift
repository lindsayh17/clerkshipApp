//  ContentView.swift
//  clerkshipApp

import SwiftUI
import Foundation

struct EvaluationView: View {
    // State variables to track user answers
    @State private var question1 = ""
    @State private var question2 = ""
    @State private var question3 = ""
    @State private var question4 = ""
    @State private var question5 = ""
    @State private var notes = ""
    
    // Navigation after submission
    @State private var submitted = false
    
    func verifyAlphaNum(testString: String) -> String{
        let regex: String = "%"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        if !test.evaluate(with: testString){
            return "Invalid characters."
        }else{
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color (dark green)
                Color(red: 0.10, green: 0.26, blue: 0.22)
                // Color fills the entire screen
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Makes scrollable
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            
                            // Each question section
                            QuestionView(question: "Patient assessment ~ Can student take patient history?", selection: $question1)
                            QuestionView(question: "Physical examination ~ Is student able to perform physical exam with appropriate technique and respect for patient?", selection: $question2)
                            QuestionView(question: "Clinical reasoning ~ Does the student demonstrate ability to remember patient history and exam to formulate a diagnosis and defend it?", selection: $question3)
                            QuestionView(question: "Case presentation ~ Can student present case accurately to preceptor?", selection: $question4)
                            QuestionView(question: "Documentation ~ Is student's documentation clear and comprehensive?", selection: $question5)
                            
                            // Notes input section
                            VStack(alignment: .leading) {
                                Text("Notes :")
                                    .foregroundColor(.white)
                                
                                // Box for comments
                                TextEditor(text: $notes)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                Text(verifyAlphaNum(testString: notes)).foregroundColor(.red)
                            }
                            
                            // Submit button
                            Button(action: {
                                print("Form submitted")
                                submitted = true
                            }) {
                                Text("Submit Form")
                                    .foregroundColor(.white)
                                    .padding()
                                    // Width
                                    .frame(maxWidth: .infinity)
                                    // Olive green color
                                    .background(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .cornerRadius(30)
                            }
                            .padding(.top, 10)
                        }
                        // Space around form content
                        .padding()
                    }
                    
                    // Bottom white transparent nav bar
                    ZStack {
                        // Color + rounded corners
                        Color.white
                            // Transparency
                            .opacity(0.6)
                            .cornerRadius(35)
                            .frame(height: 90)
                            // Side spacing
                            .padding(.horizontal, 25)
                            // Bottom spacing
                            .padding(.bottom, 10)
                        
                        // Feedback & Profile buttons
                        HStack(spacing: 60) {
                            // Feedback button
                            VStack {
                                Circle()
                                    // Olive green
                                    .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .frame(width: 50, height: 50)
                                Text("Feedback")
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                            
                            // Profile button
                            VStack {
                                Circle()
                                    // Olive green
                                    .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .frame(width: 50, height: 50)
                                Text("Profile")
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $submitted) {
                    // Page after submitting
                    SubmittedView()
                }
            }
            
        }
    }
}

// QuestionView: Displays each question with Yes/No options
struct QuestionView: View {
    let question: String
    @Binding var selection: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Question text
            Text(question)
                .foregroundColor(.white)
            
            // Yes/No radio buttons
            HStack {
                RadioButton(label: "Yes", isSelected: selection == "Yes") {
                    selection = "Yes"
                }
                RadioButton(label: "No", isSelected: selection == "No") {
                    selection = "No"
                }
            }
        }
    }
}

// Radio Buttons for Yes/No
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


// Page After Submission
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
    EvaluationView()
}
