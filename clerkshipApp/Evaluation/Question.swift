//  QuestionEntry.swift
//  clerkshipApp

import SwiftUI

// required for question's conformance to Codable
enum CodingKeys: CodingKey {
    case id
    case question
    case type
    case required
    case response
    case answered
}

// four selection options for radio questions
enum ResponseLabel: CaseIterable, Codable {
    case novice
    case apprentice
    case expert
    case none
}

class Question: Identifiable, Codable, ObservableObject {

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
    
    // required for conformance to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        type = try container.decode(QuestionType.self, forKey: .type)
        required = try container.decode(Bool.self, forKey: .required)
        response = try container.decode(ResponseLabel.self, forKey: .response)
        isAnswered = try container.decode(Bool.self, forKey: .answered)
    }

    // required for conformance to Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(question, forKey: .question)
        try container.encode(type, forKey: .type)
        try container.encode(required, forKey: .required)
        try container.encode(response, forKey: .response)
        try container.encode(isAnswered, forKey: .answered)
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
