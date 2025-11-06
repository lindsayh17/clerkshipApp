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
    @Published var users: [User]!
    @Published var downloadSuccessful = false
    @Published var currUser: User!
    
    // TODO: user collection values
    let userCollection = "Users"
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
        users = []
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
    func fetchUsers() async throws{
        var fecthedUsers: [User] = []
        do {
          let querySnapshot = try await db.collection(userCollection).getDocuments()
          for document in querySnapshot.documents {
              let data = document.data()
              
              // try to cast to strings otherwise return empty
              let firstName = data["firstName"] as? String ?? ""
              let lastName = data["lastName"] as? String ?? ""
              let email = data["email"] as? String ?? ""

              if firstName != "" && lastName != "" && email != ""{
                  let u = User(firstName: firstName, lastName: lastName, email: email)
                  fecthedUsers.append(u)
              }
          }
            for user in fecthedUsers {
                DispatchQueue.main.async{
                    self.users.append(user)
                }
            }
            
            DispatchQueue.main.async{
                self.downloadSuccessful = true
            }
        } catch {
          print("Error getting documents: \(error)")
        }
    }
    
    func fetchUser(currEmail: String) async throws{
        if currEmail != nil{
            var fetchedUser: User?
            do {
                let querySnapshot = try await db.collection(userCollection)
                    .whereField("email", isEqualTo: currEmail)
                    .getDocuments()
                print(querySnapshot.documents.count)
                for document in querySnapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let userPriv = data["privilege"] as? String ?? ""
                    
                    switch userPriv {
                    case "student":
                        fetchedUser = User(firebaseID: id, firstName: firstName, lastName: lastName, email: email, access: .student)
                    case "preceptor":
                        fetchedUser = User(firstName: firstName, lastName: lastName, email: email, access: .preceptor)
                    case "admin":
                        fetchedUser = User(firstName: firstName, lastName: lastName, email: email, access: .admin)
                    default:
                        fetchedUser = User(firstName: firstName, lastName: lastName, email: email)
                    }
                }
                
                DispatchQueue.main.async{
                    self.currUser = fetchedUser
                }
                
                DispatchQueue.main.async{
                    self.downloadSuccessful = true
                }
                
            }
        }
    }

    // data is a dictionary; keys are field names in the document
}
