//  Form.swift
//  clerkshipApp

import Foundation

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
    
    // Validation
    func validForm() -> Bool {
        // Ensures all required questions are answered
        for cat in categories {
            for question in cat.questions where question.required == true {
                if question.response == nil {
                    return false
                }
            }
        }
        return true
    }
}
