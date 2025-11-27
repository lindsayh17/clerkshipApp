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
    private let buttonColor = Color("ButtonColor")
    
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
            
            VStack(alignment: .leading, spacing: 20){
                BackButton()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
                
                Text("Evaluation Summary")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                let averages = evalStore.averageScores()
                if averages.isEmpty {
                    Text("No evaluations yet")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                } else{
                    Chart{
                        ForEach(Array(averages), id: \.key) { item in
                            BarMark(
                                x: .value("Category", item.key), // Category name (key)
                                y: .value("Average Score", item.value) // Average score (value)
                            )
                            .foregroundStyle(Color.blue.gradient)
                            .cornerRadius(8)
                            .annotation(position: .top) {
                                Text(String(format: "%.2f", item.value))
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top, 2)
                            }
                        }
                    }
                    .chartYScale(domain: 0...4) // Max score = 4
                    .frame(height: 300)
                    .padding(.horizontal) // Horizontal padding for chart
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white.opacity(0.1)) // Light background for the chart
                            .shadow(radius: 10) // Shadow for better depth
                    )
                    .padding(.vertical)
                }
                
                Spacer()
            }
            
            
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
        .environmentObject(FirebaseService())
}
