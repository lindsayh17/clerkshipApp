//  LocationsView.swift
//  clerkshipApp

import SwiftUI

struct LocationsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @Environment(\.dismiss) var dismiss
    @State private var currentView: Destination = .home
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
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
                            MainButtonView(title: "CVMC", color: buttonColor) {
                                router.push(.cvmc)
                            }
                            MainButtonView(title: "Porter Medical Center", color: buttonColor) {
                                router.push(.pmc)
                            }

                            MainButtonView(title: "RRMC", color: buttonColor) {
                                router.push(.rrmc)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    .padding(.top, 10)
                }
            }
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden()
    }
}

// Preview
#Preview {
    NavigationStack {
        LocationsView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

