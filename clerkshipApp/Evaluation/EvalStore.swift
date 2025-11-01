//
//  FormStore.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/25/25.
//


import Firebase

class EvalStore: ObservableObject {
    private var db = Firestore.firestore()
    
    func add(evaluation: Evaluation) {
        do {
          try db.collection("Evaluations").addDocument(from: evaluation)
        } catch let error {
          print("Error writing responses to Firestore: \(error)")
        }
    }
  
} // class EvalStore
