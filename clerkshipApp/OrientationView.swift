//  OrientationView.swift
//  clerkshipApp

import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss

    @State private var navigateHome: Bool = false
    @State private var currentView: Destination = .home
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack() {
                ScrollView {
                    VStack() {

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
                        
                        // Buttons
                        VStack(spacing: 15) {
                            MainButtonView(title: "Schedule", color: buttonColor) {
                                router.push(.schedule)
                            }
                            MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                            MainButtonView(title: "Family Planning Session", color: buttonColor) {
                                router.push(.familyPlan)
                            }
                            MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor) {
                                router.push(.trauma)
                            }
                            MainButtonView(title: "EPIC Orientation", color: buttonColor)
                            MainButtonView(title: "Surgical Instruments", color: buttonColor) {
                                router.push(.surgicalInst)
                            }
                            MainButtonView(title: "Locations", color: buttonColor) {
                                router.push(.locations)
                            }
                        }
                        .padding(.horizontal, 20)
                        .navigationBarBackButtonHidden(false)

                    }
                    .padding(.top, 10)
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

// Preview
#Preview {
    NavigationStack {
        OrientationView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
