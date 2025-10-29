//
//  FormStore.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/25/25.
//


import Firebase

class EvalStore: ObservableObject {
  @Published var allForms: [Form]
    private var db = Firestore.firestore()
    
    init(allForms: [Form]) {
        self.allForms = allForms
    }
    
    func add(form: Form) {
        do {
          // 2. Add the form to the Firestore "forms" collection
            _ = try db.collection("forms").addDocument(from: form)
        } catch {
            print("Error adding form to Firestore: \(error)")
        }
    }
  
} // class QuizStore
