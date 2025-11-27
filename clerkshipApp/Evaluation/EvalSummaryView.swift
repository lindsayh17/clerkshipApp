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
            
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                
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
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
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
