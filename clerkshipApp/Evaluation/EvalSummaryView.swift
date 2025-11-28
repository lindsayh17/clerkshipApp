//  EvalSummaryView.swift
//  clerkshipApp

import SwiftUI
import Charts

struct EvalSummaryView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var router: Router
        
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
                    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 0){
                    BackButton()
                        .padding(.top, 10)
                        .padding(.leading, 10)
                        .ignoresSafeArea(.all, edges: .top)
                    
                    Text("Evaluation Summary")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .top)
                        .padding(.bottom, 20)
                    
                    
                    let averages = evalStore.averageScores()
                    if averages.isEmpty {
                        Text("No evaluations yet")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else{
                        Chart{
                            ForEach(Array(averages), id: \.key) { item in
                                BarMark(
                                    x: .value("Average Score", item.value),
                                    y: .value("Category", item.key)
                                )
                                .foregroundStyle(by: .value("Type", item.key))
                                .cornerRadius(5)
                                .annotation(position: .overlay) {
                                    Text(String(format: "%.2f", item.value))
                                        .foregroundColor(.white.opacity(0.9))
                                }
                            }
                        }
                        .padding(.vertical)
                        .padding(.trailing)
                        .chartLegend(.hidden)
                        .chartXAxis(.hidden)
                        .chartYAxis {
                            AxisMarks { label in
                                AxisValueLabel() {
                                    if let category = label.as(String.self) {
                                        Text(category)
                                            .foregroundColor(.white)
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.white.opacity(0.05))
                                .frame(maxWidth: .infinity)
                        )
                        .padding()
                    }
                }
                VStack(alignment: .center, spacing: 10) {
                    Text("Scoring legend:").font(.headline).frame(alignment: .leading).bold()
                    Text("Novice: 1").font(.subheadline).padding(.leading, 4).bold()
                    Text("Apprentice: 3").font(.subheadline).padding(.leading, 4).bold()
                    Text("Expert: 5").font(.subheadline).padding(.leading, 4).bold()
                }
                .padding()
                .background(buttonColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .foregroundColor(.white)
                
                Spacer()
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
