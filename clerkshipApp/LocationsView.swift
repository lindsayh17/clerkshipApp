//  LocationsView.swift
//  clerkshipApp

/*
 TODO: change display options for students vs. preceptors
 TODO: send each link to a dummy page
 */

import SwiftUI

struct LocationsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView: NavOption = .home
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        switch currentView {
                        case .home:
                            // Title
                            Text("Locations")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 30)
                                .padding(.bottom, 30)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Location Buttons
                            VStack(spacing: 15) {
                                MainButtonView(title: "UVMMC", color: buttonColor)
                                MainButtonView(title: "CVMC", color: buttonColor)
                                MainButtonView(title: "CVPH", color: buttonColor)
                                MainButtonView(title: "Porter Medical Center", color: buttonColor)
                                MainButtonView(title: "RRMC", color: buttonColor)
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
                
                // Bottom NavTab
                NavTab(currentTab: $currentView)
            }
        }
    .navigationBarBackButtonHidden()
    }
}

// Preview
#Preview {
    LocationsView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
}

