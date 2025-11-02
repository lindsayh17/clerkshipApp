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
    func fetchUsers() async throws -> [User] {
        var users: [User] = []
        do {
          let querySnapshot = try await db.collection("Users").getDocuments()
          for document in querySnapshot.documents {
              let data = document.data()
              
              // try to cast to strings otherwise return empty
              let firstName = data["firstName"] as? String ?? ""
              let lastName = data["lastName"] as? String ?? ""
              let email = data["email"] as? String ?? ""


              let u = User(firstName: firstName, lastName: lastName, email: email)
              users.append(u)
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        
        return users
    }

    // data is a dictionary; keys are field names in the document
}
