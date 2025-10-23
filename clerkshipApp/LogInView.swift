//
//  LogInView.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 10/17/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


class FirebaseService: ObservableObject {
//    @Published private(set) var forms: [EvaluationForm]
//    @Published var downloadSuccessful = false
    let formCollectionName = "Forms"
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }

    func fetchForms() async throws {
        let querySnapshot = try await db.collection(formCollectionName).getDocuments()
        for document in querySnapshot.documents {
            let data = document.data()
            print(data)
        }
    }

    // data is a dictionary; keys are field names in the document
}
