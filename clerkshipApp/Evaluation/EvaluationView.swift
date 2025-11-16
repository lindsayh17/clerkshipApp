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
    @EnvironmentObject var formStore: FormStore
    
    @State private var navigateSearch: Bool = false
    @State private var form = Form()
    @State private var submitted = false
    
    @State private var showInfo = false
    @State private var selection: OptionDefinition = .none
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // For if a student pulls the form up
    @State private var preceptorEmail: String = ""
    
    // TODO: display this somewhere
    let currStudent: User
    
    // Firebase download (if needed)
    func download() {
        Task {
            do {
                try await firebase.fetchForms()
                if firebase.formDownloadSuccessful{
                    for form in firebase.forms{
                        formStore.addForm(form)
                    }
                }
            } catch {
                print("Error fetching forms: \(error)")
            }
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
                headerItem(title: "N/A", option: .none)
                headerItem(title: "Novice", option: .novice)
                headerItem(title: "Apprentice", option: .apprentice)
                headerItem(title: "Expert", option: .expert)
            }.alert(infoTitle(for: selection), isPresented: $showInfo) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("help")
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
        ZStack (alignment: .topLeading) {
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
                            .padding(.top, 50)
                        
                        // Radio button headers
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
                        
                        // Student-only preceptor email field (once at the bottom)
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
                            .padding(.top, 15)
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
                        .disabled(!form.validForm() || (currUser.user?.access == .student && preceptorEmail.trimmingCharacters(in: .whitespaces).isEmpty))
                        .padding(.top, 20)
                    }
                    .padding()
                }
                .navigationDestination(isPresented: $submitted) {
                    SubmittedView()
                }
            }
            
            // Back button to search
            SearchViewBackButton(navigateSearch: $navigateSearch)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
    .navigationDestination(isPresented: $navigateSearch) {
        SearchView()
            .transition(.move(edge: .leading))
    }
    .navigationBarBackButtonHidden(true)
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
    NavigationStack {
        EvaluationView(currStudent: User(firstName: "Place", lastName: "Holder", email: "email"))
    }
    .environmentObject(FirebaseService())
    .environmentObject(EvalStore())
    .environmentObject(CurrentUser())
    .environmentObject(FormStore())
}

