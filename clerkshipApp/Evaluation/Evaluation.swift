//  Evaluation.swift
//  clerkshipApp

import SwiftUI

struct Evaluation: Identifiable, Codable {
    var id = UUID()
    var formId: String                // Link to form type
    var preceptorId: String           // ID of preceptor filling out the form
    var studentId: String             // ID of student being evaluated
    var responses: [[Response]]
    var submittedAt: Date
    
    init(formId: String, preceptorId: String, studentId: String, responses: [[Response]], submittedAt: Date) {
        self.formId = formId
        self.preceptorId = preceptorId
        self.studentId = studentId
        self.responses = responses
        self.submittedAt = submittedAt
    }
}

struct Response: Identifiable, Codable {
    var id = UUID()
    var questionId: String
    var answer: String
    var responseCat: String
    
    init(questionId: String, answer: String, responseCat: String) {
        self.questionId = questionId
        self.answer = answer
        self.responseCat = responseCat
    }
}
