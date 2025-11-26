//  Form.swift
//  clerkshipApp

import Foundation

// defines the currently blank form objects
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
