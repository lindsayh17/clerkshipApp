//
//  EvalSummaryView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/26/25.
//

import SwiftUI

struct EvalSummaryView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var router: Router
        
    private let backgroundColor = Color("BackgroundColor")
    
    // download evaluations from firebase
    func getEvals() {
        Task {
            do {
                try await firebase.fetchCompletedEvals(student: currUser.user!)
                if firebase.downloadSuccessful {
                    for eval in firebase.userEvals {
                        evalStore.addFetchedEvals(eval)
                        print(eval)
                    }
                }
            } catch {
                print("Error fetching evaluations: \(error)")
            }
        }
    }
            
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
            
            
        }
        .task {
            getEvals()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EvalSummaryView()
        .environmentObject(EvalStore())
        .environmentObject(CurrentUser())
}
