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
            
            VStack(alignment: .leading, spacing: 20){
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
                            .cornerRadius(5)
                            .annotation(position: .overlay) {
                                Text(String(format: "%.2f", item.value))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .chartLegend(.hidden)
                    .chartXAxis(.hidden)
                    .chartYAxis {
                        AxisMarks { label in
                            AxisValueLabel() {
                                if let category = label.as(String.self) {
                                    Text(category)
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .chartPlotStyle(content: { plotContent in
                        plotContent
                            .background(.thinMaterial.opacity(0.1))

                    })
                    .padding()
                }
                
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
