//
//  EvalSummaryView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/26/25.
//

import SwiftUI

struct EvalSummaryView: View{
    
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var currentUser: CurrentUser
    @EnvironmentObject var evalStore: EvalStore
    
    func getEvals(){
        Task {
            do {
                if let u = currentUser.user{
                    try await firebase.fetchCompletedEvals(student: u)
                    for eval in firebase.userEvals{
                        evalStore.getComplete(evaluation: eval)
                    }
                }
            } catch {
                print("Error fetching forms")
            }
        }
    }
    
    var body: some View{
        
    }
}
