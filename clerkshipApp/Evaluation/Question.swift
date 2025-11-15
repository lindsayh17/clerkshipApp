//  QuestionEntry.swift
//  clerkshipApp

import SwiftUI

// defines the form objects
struct EvalForm: Identifiable, Codable {
    var id = UUID()
    var type: String
    var categories: [QuestionCategory]
    var formChoice: FormChoice
    
    init(categories: [QuestionCategory], type: String, formChoice: FormChoice) {
        self.categories = categories
        self.type = type
        self.formChoice = formChoice
    }
}

// This is going to hold a bunch of questions
struct QuestionCategory: Identifiable, Codable {
    // Properties
    var id = UUID()
    var category: String // Physical exam, collecting info, etc
    var questions: [Question] // sub aspects of the overall category
    
    init(category: String, questions: [Question]) {
        self.category = category
        self.questions = questions
    }
}

// required for conformance to Codable
enum CodingKeys: CodingKey {
  case question
  case response
  case answered
}


class Question: Identifiable, Codable, ObservableObject {
    
    // Question Types
    enum QuestionType: Codable {
        case radio
        case open
        case slider
    }
    
    // Properties
    var id = UUID()
    var question: String = ""
    var type: QuestionType
    var required: Bool = true
    var response: ResponseLabel?
    var isAnswered: Bool = false
    
    // Initializer
    init(question: String, type: QuestionType, required: Bool) {
        self.question = question
        self.type = type
        self.required = required
        self.response = nil
    }
    
    // Initializer w/o questionType or required
    init(question: String) {
        self.question = question
        self.type = .radio
        self.required = true
        self.response = nil
    }
    
    // Text type
//    var responseString: String? {
//        // Returns the text value if response is a text type
//        if case let .text(value)? = response {
//            return value
//        }
//        return nil
//    }
    
    // required for conformance to Codable
      required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(ResponseLabel.self, forKey: .response)
        isAnswered = try container.decode(Bool.self, forKey: .answered)
        question = try container.decode(String?.self, forKey: .question)
      }
      
      // required for conformance to Codable
      func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(response, forKey: .response)
        try container.encode(answered, forKey: .answered)
        try container.encode(questionText, forKey: .questionText)
        try container.encode(correctResponse, forKey: .correctResponse)
      }

}

enum ResponseLabel: CaseIterable, Codable {
    case novice
    case apprentice
    case expert
    case none
}

// Response Types
//enum ResponseType: Codable {
//    case text(String)
//    case number(Int)
//}

struct FillOutFormView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    
    @State private var submitted = false
    @State var currForm: EvalForm
    @State var showLabels = false
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")

    let currStudent: User
    
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
                questionResponses.append(Response(questionId: q.id.uuidString, answer: infoTitle(for: q.response ?? .none), responseCat: cat.category))
            }
            return questionResponses
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
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                // Title
                Text("\(currForm.type) Evaluation")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
                
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
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 6)
                        
                        ForEach (cat.questions) { q in
                            
                            // call the rowview
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
                    RadioButton(question: question, response: opt)
                }
            }.padding(.vertical, 4)
            
            Divider().background(Color.gray)
        }
    }
}

//
// Radio Button
//
struct RadioButton: View {
    @ObservedObject var question: Question
    var response: ResponseLabel
    
    var body: some View {
        var image = question.isAnswered ? "circle.inset.filled" : "circle"
        var color: Color = question.isAnswered ? .purple : .white
        
        Image(systemName: image)
            .foregroundColor(color)
        
        .buttonStyle(BorderlessButtonStyle())
        .frame(maxWidth: .infinity)
    }
}
