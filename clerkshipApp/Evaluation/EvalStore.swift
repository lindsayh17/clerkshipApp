//  FormStore.swift
//  clerkshipApp

import Firebase

class EvalStore: ObservableObject {
    private var db = Firestore.firestore()
    @Published var currUserEvals: [Evaluation] = []
    
    func add(evaluation: Evaluation) {
        do {
          try db.collection("Evaluations").addDocument(from: evaluation)
        } catch let error {
          print("Error writing responses to Firestore: \(error)")
        }
    }
    
    func getComplete(evaluation: Evaluation){
        currUserEvals.append(evaluation)
    }
  
}
