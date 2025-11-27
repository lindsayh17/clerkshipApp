//  FormStore.swift
//  clerkshipApp

import Firebase

class EvalStore: ObservableObject {
    private var db = Firestore.firestore()
    @Published var currUserEvals: [Evaluation] = []
    
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
        if !(currUserEvals.contains(where: {$0.id == eval.id} )) {
            currUserEvals.append(eval)
        }
    }
    
    func getNumEvals() -> Int {
        return currUserEvals.count
    }
    
    
    // Get score values for the each response
    func scoreValue(for response: String) -> Double? {
        switch response.lowercased() {
        case "novice": return 1
        case "advanced": return 3
        case "expert": return 5
        case "n/a": return nil
        default: return nil
        }
    }
    
    func averageScores() -> [String: Double] {
        var categoryTotals: [String: Double] = [:]
        var categoryCounts: [String: Int] = [:]
        
        for eval in currUserEvals {
            for (category, questions) in eval.responses {
                for (_, response) in questions {
                    if let score = scoreValue(for: response) {
                        categoryTotals[category, default: 0] += score
                        categoryCounts[category, default: 0] += 1
                    }
                }
            }
        }
        
        var averages: [String: Double] = [:]
        for (category, total) in categoryTotals {
            if let count = categoryCounts[category], count > 0 {
                averages[category] = total / Double(count)
            }
        }
        
        return averages
    }
      
}
