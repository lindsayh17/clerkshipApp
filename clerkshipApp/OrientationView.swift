// OrientationView.swift
// clerkshipApp

import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Title
                    Text("Orientation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Description
                    Text("OBGYN orientation will be on Monday, May 12th at UVM for all VT Campus students before traveling to their respective sites.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 10)
                    
                    // Sections
                    VStack(spacing: 25) {
                        // Orientation Basics
                        DisclosureGroup("Orientation Basics") {
                            VStack(spacing: 15) {
                                MainButtonView(title: "Schedule", color: buttonColor) {
                                    router.push(.schedule)
                                }
                                MainButtonView(title: "Locations", color: buttonColor) {
                                    router.push(.locations)
                                }
                            }
                            .padding(.top, 5)
                        }
                        .accentColor(.white)
                        .font(.headline)
                        
                        // Clinical Skills / Procedures
                        DisclosureGroup("Clinical Skills / Procedures") {
                            VStack(spacing: 15) {
                                MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                                MainButtonView(title: "Family Planning Session", color: buttonColor) {
                                    router.push(.familyPlan)
                                }
                                MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor) {
                                    router.push(.trauma)
                                }
                                MainButtonView(title: "Surgical Instruments", color: buttonColor) {
                                    router.push(.surgicalInst)
                                }
                            }
                            .padding(.top, 5)
                        }
                        .accentColor(.white)
                        .font(.headline)
                        
                        // Systems / Tools
                        DisclosureGroup("Systems / Tools") {
                            VStack(spacing: 15) {
                                MainButtonView(title: "EPIC Orientation", color: buttonColor)
                            }
                            .padding(.top, 5)
                        }
                        .accentColor(.white)
                        .font(.headline)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .padding(.top, 10)
            }
            
            // Back button
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        OrientationView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
