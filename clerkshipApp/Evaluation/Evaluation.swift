//  Evaluation.swift
//  clerkshipApp

import SwiftUI

// a completed form
struct Evaluation: Identifiable, Codable, Hashable {
    var id: String?
    var formType: String             // Link to form type
    var preceptorId: String        // ID of preceptor filling out form
    var studentId: String          // ID of student being evaluated
    var responses: [String: [String: String]]
    var submittedAt: Date
    var notes = ""
    
    init(formType: String, preceptorId: String, studentId: String, responses: [String: [String: String]], submittedAt: Date) {
        self.formType = formType
        self.preceptorId = preceptorId
        self.studentId = studentId
        self.responses = responses
        self.submittedAt = submittedAt
    }
    
    init(formType: String, preceptorId: String, studentId: String, responses: [String: [String: String]], submittedAt: Date, notes: String) {
        self.formType = formType
        self.preceptorId = preceptorId
        self.studentId = studentId
        self.responses = responses
        self.submittedAt = submittedAt
        self.notes = notes
    }
    
    init(id: String? = nil, formType: String, preceptorId: String, studentId: String, responses: [String: [String: String]], submittedAt: Date, notes: String) {
        self.id = id
        self.formType = formType
        self.preceptorId = preceptorId
        self.studentId = studentId
        self.responses = responses
        self.submittedAt = submittedAt
        self.notes = notes
    }
}

struct Response: Identifiable, Codable {
    var id = UUID()
    var question: String
    var answer: String
    var responseCat: String
    
    init(question: String, answer: String, responseCat: String) {
        self.question = question
        self.answer = answer
        self.responseCat = responseCat
    }
}
