//
//  QuestionEntry.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/17/25.
//

import SwiftUI

struct Question: Identifiable{
    
    enum QuestionType{
        case radio
        case open
        case slider
    }
    
    enum ResponseType{
        case text(String)
        case number(Int)
    }
        
    var id = UUID()
    var question: String = ""
    var type: QuestionType
    var required: Bool = true
    var response: ResponseType?
    
    init(question: String, type: QuestionType, required: Bool){
        self.question = question
        self.type = type
        self.required = required
        self.response = nil
    }
    
    var responseString: String? {
        if case let .text(value)? = response{
            return value
        }
        return nil
    }
}
