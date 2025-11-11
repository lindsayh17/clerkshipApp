//  OrientationView.swift
//  clerkshipApp

import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView: NavOption = .home
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            switch currentView {
                            case .home:
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
                                    .padding(.vertical, 10)
                                    .padding(.bottom, 10)
                                
                                // Buttons
                                VStack(spacing: 15) {
                                    MainButtonView(title: "Schedule", color: buttonColor)
                                    MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                                    MainButtonView(title: "Family Planning Session", color: buttonColor)
                                    MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor)
                                    MainButtonView(title: "EPIC Orientation", color: buttonColor)
                                    MainButtonView(title: "Surgical Instruments", color: buttonColor)
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 30)
                                
                            case .resources:
                                ResourcesView()
                            case .search:
                                SearchView()
                            case .profile:
                                ProfileView()
                            case .users:
                                SearchView()
                            case .eval:
                                SearchView()
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    // Bottom navigation
                    NavTab(currentTab: $currentView)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

// Preview
#Preview {
    OrientationView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
}

