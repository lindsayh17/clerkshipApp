//
//  EvaluationSummaryMiniView.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/26/25.
//

import SwiftUI

struct EvaluationSummaryMiniView: View {
    @EnvironmentObject var currUser: CurrentUser
    
    // Mocked data for now — you can replace this with Firestore values later
    let avgScore: Double = 4.6
    let totalEvals: Int = 12
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Evaluation Summary")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                SummaryStat(title: "Average Score", value: String(format: "%.1f", avgScore))
                SummaryStat(title: "Evaluations", value: "\(totalEvals)")
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
