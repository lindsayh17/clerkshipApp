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
                        "**All students**",
                        "*Simulation Center - Rowell 2nd Floor*",
                        "7:00am - 8:00am: Introduction & Pre-Rotation Knowledge Test (bring a computer)\n8:00am - 12:00pm: Simulation Activities & Hospital Tour",
                        "**All students**",
                        "*Meded 302/303*",
                        "Hot lunch will be served - please email Sara Tourville with any food/allergy considerations.",
                        "12:00pm: Lunch & Clerkship Information\n12:30pm - 1:30pm: Intrapartum FHR Interpretation Teaching Session\n1:30pm - 1:45pm: Break\n1:45pm - 2:30pm: Labor Support and Trauma Informed Care Session\n2:30pm - 3:30pm: Family Planning on the OBGyn Clerkship",
                        "**L. Amaio, J. Bates, A. Gorbacheva, J. Reigle, B. Sebuufu**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:45pm: Pelvic & Breast Refresher"
                    ]),
        ScheduleData(title: "Tuesday 10/14",
                      descriptions:  [
                        "**K. Blau, B. Canova, J. Hurley, R. Marawala**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:15pm: Pelvic & Breast Refresher"
                    ]),
        ScheduleData(title: "Wednesday 10/15",
                      descriptions:  [
                        "**C. Bauman, J. Du, M. Lapointe-Gagner, S. Tukel**",
                        "*Given Assessment Center*",
                        "5:45pm - 8:15pm: Pelvic & Breast Refresher"
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
                                            Text(LocalizedStringKey(desc))
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
