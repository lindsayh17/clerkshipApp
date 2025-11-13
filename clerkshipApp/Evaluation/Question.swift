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


struct Question: Identifiable, Codable {
    
    // Question Types
    enum QuestionType: Codable {
        case radio
        case open
        case slider
    }
    
    // Response Types
    enum ResponseType: Codable {
        case text(String)
        case number(Int)
    }
    
    // Properties
    var id = UUID()
    var question: String = ""
    var type: QuestionType
    var required: Bool = true
    var response: ResponseType?
    
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
    var responseString: String? {
        // Returns the text value if response is a text type
        if case let .text(value)? = response {
            return value
        }
        return nil
    }
}

enum ResponseLabel: CaseIterable {
    case novice
    case apprentice
    case expert
    case none
}

struct FillOutFormView: View {
    @State private var submitted = false
//    @State var form: EvalForm
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    let currForm: EvalForm
    
    
    private func questionRow(q: Question) -> some View {
        VStack {
            Text(q.question)
                .foregroundColor(.white)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                ForEach(ResponseLabel.allCases, id: \.self) { opt in
                    Button {
//                        q.response = .text(infoTitle(for: opt))
                        
                    } label: {
                        Image(systemName: "circle.inset.filled")
                            .foregroundColor(.white)
                            .baselineOffset(1)
                            .font(.system(size: 12))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(maxWidth: .infinity)
                }.padding(.vertical, 8)
            }
            Divider().background(Color.gray)
        }
    }
    

    private func infoTitle(for opt: ResponseLabel) -> String {
        switch opt {
        case .novice: return "Novice"
        case .apprentice: return "Apprentice"
        case .expert: return "Expert"
        case .none: return "None"
        }
    }
        
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                // Title
                Text(currForm.type)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                ScrollView {
                    ForEach (currForm.categories) { category in
                        Text(category.category)
                        
                        ForEach (category.questions) { question in
                            questionRow(q: question)
                        }
                        
                    }
                }
            }
        }
    }
}
