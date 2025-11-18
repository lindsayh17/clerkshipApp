//  FormStore.swift
//  clerkshipApp

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
  
}
