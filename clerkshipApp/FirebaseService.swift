//  LogInView.swift
//  clerkshipApp

import SwiftUI
import FirebaseCore
import FirebaseFirestore
// import FirebaseAuth

class FirebaseService: ObservableObject {
//    @Published private(set) var forms: [EvaluationForm]
//    @Published var downloadSuccessful = false
    let formCollectionName = "Forms"
    
    // TODO: user collection values
    let userCollectionName = " "
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }

    // function to fetch form info from firebase
    func fetchForms() async throws {
        let querySnapshot = try await db.collection(formCollectionName).getDocuments()
        for document in querySnapshot.documents {
            let data = document.data()
            print(data)
        }
    }
    
    // function to fetch user info from firebase
    // TODO: right now fetchUsers is defunct b/c no collection like that so far
    func fetchUsers() async throws {
        do {
          let querySnapshot = try await db.collection("Users").getDocuments()
          for document in querySnapshot.documents {
            print("\(document.documentID) => \(document.data())")
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }

    // data is a dictionary; keys are field names in the document
}
