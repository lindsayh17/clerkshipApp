//  QuestionOfDay.swift
//  clerkshipApp

import SwiftUI

struct QuestionOfDay: Identifiable, Codable {
    var id = UUID()
    var questionText: String
    var answer: String
    
    init(questionText: String, answer: String) {
        self.questionText = questionText
        self.answer = answer
    }
}
