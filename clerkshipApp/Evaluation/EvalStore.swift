//  FormStore.swift
//  clerkshipApp

import Firebase

class EvalStore: ObservableObject {
    @Published var allEvals: [Evaluation] = []
    private var db = Firestore.firestore()
    
    // adds completed eval to firestore
    func addToFirestore(evaluation: Evaluation) {
        do {
          try db.collection("Evaluations").addDocument(from: evaluation)
        } catch let error {
          print("Error writing responses to Firestore: \(error)")
        }
    }
    
    // add completed evals from firestore to list
    func addFetchedEvals(_ eval: Evaluation) {
        allEvals.append(eval)
    }
    
  
}
