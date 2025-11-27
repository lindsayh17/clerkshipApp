//  FormState.swift
//  clerkshipApp

import SwiftUI

class EvalFormState: ObservableObject {
    let data: EvalForm

    @Published var responses: [String: ResponseLabel] = [:]
    @Published var notes: String = ""

    init(data: EvalForm) {
        self.data = data
    }

    func validForm() -> Bool {
        for category in data.categories {
            for question in category.questions where question.required {
                if responses[question.question] == nil {
                    return false
                }
            }
        }
        return true
    }
}
