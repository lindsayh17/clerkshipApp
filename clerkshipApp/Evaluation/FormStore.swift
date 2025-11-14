//  FormStore.swift
//  clerkshipApp

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
