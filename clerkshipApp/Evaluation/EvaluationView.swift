//  EvaluationView.swift
//  clerkshipApp

/*
 TODO: link student, preceptor, form type ids to firebase write
 TODO: display a list of completed evaluations somewhere for the preceptors
*/
import SwiftUI

struct FillOutFormView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    @State var showLabels = false
    @State private var submitted = false
    
    @State var currForm: EvalForm
    let currStudent: User
    
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
        let responses = currForm.categories.compactMap { cat -> [Response]? in
            let questions = cat.questions
            var questionResponses: [Response] = []
            
            for q in questions {
                questionResponses.append(
                    Response(
                        questionId: q.id.uuidString,
                        answer: infoTitle(for: q.response ?? .none),
                        responseCat: cat.category)
                )
            }
            return questionResponses
        }
        
        let evaluation = Evaluation(
            formId: currForm.type,
            preceptorId: currUser.user?.firebaseID ?? "0",
            studentId: currStudent.firebaseID,
            responses: responses,
            submittedAt: Date()
        )
        
        evalStore.add(evaluation: evaluation)
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                // Title
                Text("\(currForm.type) Evaluation")
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
                }
            }
        }
    }
}

struct QuestionRowView: View {
    @ObservedObject var question: Question
    
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
                        question.response = opt
                    }) {
                        Image(systemName: question.response == opt ? "circle.inset.filled" : "circle")
                            .foregroundColor(question.response == opt ? .purple : .white)
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
