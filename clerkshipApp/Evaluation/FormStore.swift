//
//  FormStore.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/11/25.
//

import SwiftUI

class FormStore: ObservableObject{
    @Published var allForms: [EvalForm] = []
    
    func addForm(_ form: EvalForm){
        allForms.append(form)
    }
}


class CurrentForm: ObservableObject{
    @Published var form: EvalForm?
}
