//  ContentView.swift
//  clerkshipApp

import SwiftUI
import Foundation

struct EvaluationView: View {
    // State variables to track user answers
    @State private var questionIndex = 0
    @State private var form = Form()
    
    // Navigation after submission
    @State private var submitted = false
    @State private var complete = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background color (dark green)
                Color(red: 0.10, green: 0.26, blue: 0.22)
                // Color fills the entire screen
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Makes scrollable
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            ForEach($form.questions){$q in
                                if q.required{
                                    Text(q.question).foregroundColor(.white) + Text(" *").foregroundColor(.red)
                                }else{
                                    Text(q.question).foregroundColor(.white)
                                }
                                switch q.type{
                                case.radio:
                                    HStack {
                                        RadioButton(label: "Yes", isSelected: (q.responseString == "Yes")){
                                            q.response = .text("Yes")
                                        }
                                        RadioButton(label: "No", isSelected: (q.responseString == "No")){
                                            q.response = .text("No")
                                        }
                                    }
                                case .open:
                                    VStack(alignment: .leading) {
                                        
                                        // Box for comments
                                        TextEditor(text: Binding(get: {if case .text(let notes) = q.response{
                                            return notes
                                        }
                                            return ""
                                        }, set: {newVal in q.response = .text(newVal)}))
                                        .frame(height: 100)
                                        .padding(8)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        // Text(verifyAlphaNum(testString: notes)).foregroundColor(.red)
                                    }
                                case .slider:
                                    Text("Slide")
                                    //TODO: slider code
                                }
                            }
                            // Submit button
                            Button(action: {
                                print("Form submitted")
                                submitted = true
                            }){
                                Text("Submit Form")
                                    .foregroundColor(.white)
                                    .padding()
                                // Width
                                    .frame(maxWidth: .infinity)
                                // Olive green color
                                    .background(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .cornerRadius(30)
                            }
                            .disabled(complete)
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    NavView()
                }
                .navigationDestination(isPresented: $submitted) {
                    // Page after submitting
                    SubmittedView()
                        //.onAppear() { fetchTest() }
                }
            }
        }
    }
}

struct RadioButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                // Filled or empty circle based on selection
                Image(systemName: isSelected ? "circle.inset.fislled" : "circle")
                    .foregroundColor(.white)
                Text(label)
                    .foregroundColor(.white)
            }
        }
    }
}

struct SubmittedView: View{
    var body: some View{
        VStack(spacing: 30){
            Text("Submitted!")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EvaluationView()//.environmentObject()
}
