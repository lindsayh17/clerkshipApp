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
    var date: Date
    
    init(questionText: String, date: Date) {
        self.questionText = questionText
        self.date = date
    }
}
