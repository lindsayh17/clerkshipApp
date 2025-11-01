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
            question: "Patient assessment ~ Can student take patient history?",
            type: .radio,
            required: true
        )
        let q2 = Question(
            question: "Physical examination ~ Is student able to perform physical exam with appropriate technique and respect for patient?",
            type: .radio,
            required: true
        )
        let q3 = Question(
            question: "Clinical reasoning ~ Does the student demonstrate ability to remember patient history and exam to formulate a diagnosis and defend it?",
            type: .radio,
            required: true
        )
        let q4 = Question(
            question: "Case presentation ~ Can student present case accurately to preceptor?",
            type: .radio,
            required: true
        )
        let q5 = Question(
            question: "Documentation ~ Is student's documentation clear and comprehensive?",
            type: .radio,
            required: true
        )
        let q6 = Question(
            question: "Notes:",
            type: .open,
            required: false
        )
        
        // Assign to questions array
        self.questions = [q1, q2, q3, q4, q5, q6]
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
