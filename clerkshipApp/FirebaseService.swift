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
    @Published var formDownloadSuccessful = false
    @Published var currUser: User!
    @Published var forms: [EvalForm]
    
    // TODO: user collection values
    let userCollection = "Users"
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
        users = []
        forms = []
    }

    // function to fetch form info from firebase
    func fetchForms() async throws {
        var fetchedForms: [EvalForm] = []
        let querySnapshot = try await db.collection(formCollectionName).getDocuments()
        do {
            for document in querySnapshot.documents {
                let data = document.data()
                print(data)
                
                // get the type of form
                let type = data["type"] as? String ?? ""
                
                // create a list to hold categories
                var categories: [QuestionCategory] = []
                
                // key: category, q1, q2, ...
                // value: "category name", "question 1", ...
                for (key, value) in data {
                    // only get the questions, of form q1, q2, q...
                    guard key.starts(with: "q"), let qmap = value as? [String: Any] else { continue }
                    
                    // Question Category
                    let category = qmap["category"] as? String ?? ""
                    print("category: \(category)")

                    // create a list to hold all the questions
                    var questions: [Question] = []
                    
                    // add each question to the list
                    for (qNum, qQuestion) in qmap {
                        if qNum != "category", let qQuestion = qQuestion as? String {
                            questions.append(Question(question: qQuestion))
                            print("question: \(qQuestion)")
                        }
                    }
                    categories.append(QuestionCategory(category: category, questions: questions))
                }
                
                switch type {
                case "Clinic":
                    fetchedForms.append(EvalForm(categories: categories, type: type, formChoice: .clinic))
                case "Obstetrics":
                    fetchedForms.append(EvalForm(categories: categories, type: type, formChoice: .obstetrics))
                case "Inpatient":
                    fetchedForms.append(EvalForm(categories: categories, type: type, formChoice: .inpatient))
                default:
                    fetchedForms.append(EvalForm(categories: categories, type: type, formChoice: .clinic))
                }
            }
            DispatchQueue.main.async {
                self.forms = fetchedForms
                self.formDownloadSuccessful = true
                print(self.forms)
            }
        } catch {
            print("Error getting forms \(error)")
            self.formDownloadSuccessful = false
        }
    }
    
    // function to fetch user info from firebase
    func fetchUsers() async throws{
        var fetchedUsers: [User] = []
        do {
            let querySnapshot = try await db.collection(userCollection).getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()

                // try to cast to strings otherwise return empty
                let id = data["id"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let email = data["email"] as? String ?? ""

                if firstName != "" && lastName != "" && email != ""{
                    let u = User(firebaseID: id, firstName: firstName, lastName: lastName, email: email)
                  fetchedUsers.append(u)
                }
            }
            DispatchQueue.main.async{
                self.users = fetchedUsers
                self.downloadSuccessful = true
            }
        } catch {
            print("Error getting documents: \(error)")
            DispatchQueue.main.async{
                self.downloadSuccessful = false
            }
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
                        fetchedUser = User(firebaseID: id, firstName: firstName, lastName: lastName, email: email, access: .preceptor)
                    case "admin":
                        fetchedUser = User(firebaseID: id, firstName: firstName, lastName: lastName, email: email, access: .admin)
                    default:
                        fetchedUser = User(firebaseID: id, firstName: firstName, lastName: lastName, email: email)
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
