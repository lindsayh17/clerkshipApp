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
                                x: .value("Average Score", item.value),
                                y: .value("Category", item.key)
                            )
                            .foregroundStyle(by: .value("Type", item.key))
                            .annotation(position: .trailing) {
                                Text(String(item.value))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .chartLegend(.hidden)
                    .chartXAxis(.hidden)
                    .chartYAxis {
                        AxisMarks { _ in
                            AxisValueLabel()
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
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
