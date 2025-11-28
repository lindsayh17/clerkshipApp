//  EvaluationSummaryMiniView.swift
//  clerkshipApp

import SwiftUI

struct EvaluationSummaryMiniView: View {
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var firebase: FirebaseService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Evaluation Summary")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                SummaryStat(title: "Average Score", value: evalStore.getNumEvals() != 0 ? String(format: "%.2f", evalStore.getMiniViewAvg()): "-")
                SummaryStat(title: "Evaluations", value: evalStore.getNumEvals() != 0 ? "\(evalStore.getNumEvals())": "-")
            }
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
