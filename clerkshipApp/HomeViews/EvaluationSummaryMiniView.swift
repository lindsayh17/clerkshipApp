//
//  EvaluationSummaryMiniView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/26/25.
//

import SwiftUI

struct EvaluationSummaryMiniView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var firebase: FirebaseService
    
    // Mocked data for now — you can replace this with Firestore values later
    @State var avgScore: Double = 4.6
    @State var totalEvals: Int = 12
    
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
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Evaluation Summary")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                SummaryStat(title: "Average Score", value: String(format: "%.1f", avgScore))
                SummaryStat(title: "Evaluations", value: "\(evalStore.getNumEvals())")
            }
        }
        .task {
            getEvals()
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(14)
    }
}

struct SummaryStat: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}
