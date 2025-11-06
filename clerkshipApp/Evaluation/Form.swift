//  Form.swift
//  clerkshipApp

import Foundation

struct Form:Identifiable, Codable {
    var id: UUID
    var questions: [Question]
    
    // Initializer
    init() {
        self.id = UUID()

        // Default form questions
        let q1 = Question(
            question: "Amount of information gathered",
            type: .radio,
            required: true
        )
        let q2 = Question(
            question: "Linking information in a clinically relevant fashion",
            type: .radio,
            required: true
        )
        let q3 = Question(
            question: "Patient-focused communication",
            type: .radio,
            required: true
        )
        let q4 = Question(
            question: "Tailoring history to clinical encounter",
            type: .radio,
            required: true
        )
        let q5 = Question(
            question: "Notes:",
            type: .open,
            required: false
        )
        
        // Assign to questions array
        self.questions = [q1, q2, q3, q4, q5]
    }
    
    // Validation
    func validForm() -> Bool {
        // Ensures all required questions are answered
        for question in questions where question.required == true {
            if question.response == nil {
                return false
            }
        }
        return true
    }
}
