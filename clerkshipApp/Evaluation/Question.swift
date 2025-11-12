//  QuestionEntry.swift
//  clerkshipApp

import SwiftUI

enum FormChoice: String, Codable {
    case obstetrics
    case clinic
    case inpatient
}

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


struct FormsListView: View {
    @StateObject private var firebase: FirebaseService
    
    var body: some View {
        // roght now each form links to own eval page.
        // need to combine with the formchoiceview fie so that we can use the buttons
        NavigationStack {
            List(firebase.forms) { form in
                NavigationLink(destination: FormEvalView(form: form)) {
                    VStack(alignment: .leading) {
                        Text(form.type)
                            .font(.headline)
                        Text(form.formChoice.rawValue.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }.task {
            do {
                try await firebase.fetchForms()
            } catch {
                print("Error fetching form data \(error)")
            }
        }
    }
}

struct FormEvalView: View {
    let form: EvalForm
    
    var body: some View {
        
    }
}
