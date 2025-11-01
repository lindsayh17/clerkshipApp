//
//  FormStore.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/25/25.
//


import Firebase

class EvalStore: ObservableObject {
    private var db = Firestore.firestore()
    
    func add(form: Form) {
        do {
          try db.collection("Forms").document("2").setData(from: form)
        } catch let error {
          print("Error writing city to Firestore: \(error)")
        }
    }
  
} // class QuizStore
