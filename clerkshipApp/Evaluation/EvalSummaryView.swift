//
//  EvalSummaryView.swift
//  clerkshipApp
//

import SwiftUI

struct EvalSummaryView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var router: Router
    
    var currStudent: User
    
    private let backgroundColor = Color("BackgroundColor")
    
    // download evaluations from firebase
    func getEvals() {
        Task {
            do {
                try await firebase.fetchCompletedEvals(student: currStudent)
                if firebase.downloadSuccessful {
                    for eval in firebase.userEvals {
                        evalStore.addFetchedEvals(eval)
                    }
                }
            } catch {
                print("Error fetching forms: \(error)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
        }
        
    }
}
