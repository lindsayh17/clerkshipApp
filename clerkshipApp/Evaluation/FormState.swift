//
//  FormState.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/19/25.
//

import SwiftUI

class EvalFormState: ObservableObject {
    let data: EvalForm

    @Published var responses: [UUID: ResponseLabel] = [:]
    @Published var notes: String = ""

    init(data: EvalForm) {
        self.data = data
    }

    func validForm() -> Bool {
        for category in data.categories {
            for question in category.questions where question.required {
                if responses[question.id] == nil {
                    return false
                }
            }
        }
        return true
    }
}
