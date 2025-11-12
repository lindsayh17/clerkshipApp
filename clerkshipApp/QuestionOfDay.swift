//
//  QuestionOfDay.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/11/25.
//

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
