//  QuestionEntry.swift
//  clerkshipApp

import SwiftUI

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
    
    // Text type
    var responseString: String? {
        // Returns the text value if response is a text type
        if case let .text(value)? = response {
            return value
        }
        return nil
    }
}
