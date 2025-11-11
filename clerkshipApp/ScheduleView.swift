//  ScheduleView.swift
//  clerkshipApp

import SwiftUI

struct ScheduleData: Identifiable {
    let id = UUID()
    let title: String
    let descriptions: [String]
}

struct ScheduleView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    // State for nav tab
    @State private var currentView: NavOption = .resources
    @EnvironmentObject var currUser: CurrentUser
    
    // Quick Facts data
    private let schedule: [ScheduleData] = [
        ScheduleData(title: "Monday, 10/13",
                      descriptions:  [
                        "All students. Simulation Center - Rowell 2nd Floor.",
                        "7:00am - 8:00am: Introduction & Pre-Rotation Knowledge Test (bring a computer).",
                        "8:00am - 12:00pm: Simulation Activities & Hospital Tour."
                    ]),
        ScheduleData(title: "Tuesday 10/14",
                      descriptions:  [
                        "All students. Simulation Center - Rowell 2nd Floor.",
                        "7:00am - 8:00am: Introduction & Pre-Rotation Knowledge Test (bring a computer).",
                        "8:00am - 12:00pm: Simulation Activities & Hospital Tour."
                    ]),
        ScheduleData(title: "Wednesday 10/15",
                      descriptions:  [
                        "All students. Simulation Center - Rowell 2nd Floor.",
                        "7:00am - 8:00am: Introduction & Pre-Rotation Knowledge Test (bring a computer).",
                        "8:00am - 12:00pm: Simulation Activities & Hospital Tour."
                    ])
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Title - centered
                            Text("Schedule")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 30)
                                .padding(.bottom, 15)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            // Quick Facts list - left aligned
                            VStack(alignment: .leading, spacing: 25) {
                                ForEach(schedule) { item in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.title)
                                            .font(.title)
                                            .foregroundColor(.white)
                                        
                                        ForEach(item.descriptions, id: \.self) { desc in
                                             Text(desc)
                                                 .font(.subheadline)
                                                 .foregroundColor(.white.opacity(0.8))
                                                 .padding(.leading, 8)
                                         }
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                        }
                    }
                    // Bottom Navigation
                    NavTab(currentTab: $currentView)
                }
            }
        }
    }
}

// Preview
#Preview {
    ScheduleView().environmentObject(FirebaseService()).environmentObject(CurrentUser())
}
