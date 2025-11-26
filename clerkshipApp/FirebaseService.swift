//  LogInView.swift
//  clerkshipApp

import SwiftUI
import FirebaseCore
import FirebaseFirestore
// import FirebaseAuth

class FirebaseService: ObservableObject {
    @Published var users: [User]!
    @Published var question: QuestionOfDay!
    @Published var downloadSuccessful = false
    @Published var formDownloadSuccessful = false
    @Published var currUser: User!
    @Published var forms: [EvalForm]!
    @Published var userEvals: [Evaluation]
    
    let formCollection = "Forms"
    let userCollection = "Users"
    let qCollection = "Questions"
    let evalCollection = "Evaluations"
    
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
        users = []
        forms = []
        userEvals = []
    }
    
    // function to fetch form info from firebase
    func fetchForms() async throws {
        var fetchedForms: [EvalForm] = []
        
        do {
            let querySnapshot = try await db.collection(formCollection).getDocuments()

            for document in querySnapshot.documents {
                let data = document.data()
                
                // get the type of form
                let type = data["type"] as? String ?? ""
                
                // create a list to hold categories
                var categories: [QuestionCategory] = []
                
                for (key, value) in data {
                    // only get the questions, of form q1, q2, q...
                    guard key.starts(with: "q"), let qmap = value as? [String: Any] else { continue }
                    
                    // Question Category
                    let category = qmap["Category"] as? String ?? ""
                    
                    var questions: [Question] = []
                    
                    // add each question to the list
                    for (qNum, qQuestion) in qmap {
                        if qNum != "Category", var qQuestion = qQuestion as? String {
                            questions.append(Question(question: qQuestion))
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
            }
        } catch {
            print("Error getting forms \(error)")
            DispatchQueue.main.async {
                self.formDownloadSuccessful = false
            }
        }
    }
    
    // function to fetch completed evaluations from firebase
    func fetchCompletedEvals() async throws {
        var fetchedEvals: [Evaluation] = []
        
        do {
            let querySnapshot = try await db.collection(evalCollection).getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                
                // try to cast to strings otherwise return empty
                let id = document.documentID
                let formType = data["formType"] as? String ?? ""
                let preceptorId = data["preceptorId"] as? String ?? ""
                let studentId = data["studentId"] as? String ?? ""
                let submittedAt = data["submittedAt"] as? Date ?? Date()
                let notes = data["notes"] as? String ?? ""
                
                var responses: [String: String] = [:]
                
                
                for (key, value) in data {
                    guard key.starts(with: "responses"), let responseMap = value as? [String: String] else { continue }
                    
                    // add each eval response to the responses dict
                    for (prompt, response) in responseMap {
                        responses[prompt] = response
                    }
                }
                
                fetchedEvals.append(Evaluation(
                    formType: formType,
                    preceptorId: preceptorId,
                    studentId: studentId,
                    responses: responses,
                    submittedAt: submittedAt,
                    notes: notes
                ))
            }
            DispatchQueue.main.async {
                self.userEvals = fetchedEvals
                self.downloadSuccessful = true
            }
        } catch {
            print("Error getting Evaluations: \(error)")
            DispatchQueue.main.async{
                self.downloadSuccessful = false
            }
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
                let id = document.documentID
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                
                if firstName != "" && lastName != "" && email != ""{
                    let u = User(id: id, firstName: firstName, lastName: lastName, email: email)
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
                    
                    let id = document.documentID
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let userPriv = data["access"] as? String ?? ""
                    
                    switch userPriv {
                    case "student":
                        fetchedUser = User(id: id, firstName: firstName, lastName: lastName, email: email, access: .student)
                    case "preceptor":
                        fetchedUser = User(id: id, firstName: firstName, lastName: lastName, email: email, access: .preceptor)
                    case "admin":
                        fetchedUser = User(id: id, firstName: firstName, lastName: lastName, email: email, access: .admin)
                    default:
                        fetchedUser = User(id: id, firstName: firstName, lastName: lastName, email: email)
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
    
    func fetchRandomQuestion() async throws{
        var fetchedQuestions: [QuestionOfDay] = []
        do {
            let querySnapshot = try await db.collection(qCollection).getDocuments()
            for document in querySnapshot.documents {
                let data = document.data()
                
                // try to cast to strings otherwise return empty
                let question = data["question"] as? String ?? ""
                let answer = data["answer"] as? String ?? ""
                
                if question != "" && answer != ""{
                    let q = QuestionOfDay(questionText: question, answer: answer)
                    fetchedQuestions.append(q)
                }
            }
            DispatchQueue.main.async{
                self.question = fetchedQuestions.randomElement()
                self.downloadSuccessful = true
            }
        } catch {
            print("Error getting documents: \(error)")
            DispatchQueue.main.async{
                self.downloadSuccessful = false
            }
        }
    }
}
