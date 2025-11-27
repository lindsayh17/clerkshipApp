//
//  EvalSummaryView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/26/25.
//

import SwiftUI
import Charts

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
                if let u = currUser.user{
                    try await firebase.fetchCompletedEvals(student: u)
                    if firebase.downloadSuccessful {
                        for eval in firebase.userEvals {
                            evalStore.addFetchedEvals(eval)
                            print(eval)
                        }
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
            
            
            let averages = evalStore.averageScores()
            
            Chart{
                ForEach(Array(averages), id: \.key) { item in
                    BarMark(
                        x: .value("Category", item.key), // Category name (key)
                        y: .value("Average Score", item.value) // Average score (value)
                    )
                    .foregroundStyle(Color.green.gradient)
                    .annotation(position: .top) {
                        Text(String(format: "%.2f", item.value))
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EvalSummaryView()
        .environmentObject(EvalStore())
        .environmentObject(CurrentUser())
        .environmentObject(FirebaseService())
}
