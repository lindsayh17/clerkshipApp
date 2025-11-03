//  HomeView.swift
//  clerkshipApp

import SwiftUI

struct HomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @State private var currentView = NavOption.home
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fill the screen with background color
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    // Scrollable content
                    ScrollView {
                        VStack(alignment: .leading, spacing: 40) {
                            switch currentView {
                            case .home:
                                // Quick Facts Section
                                SectionView(title: "Quick Facts") {
                                    Text("View Quick Facts")
                                }
                                // Orientation Section
                                SectionView(title: "Orientation") {
                                    Text("View Orientation Details")
                                }
                                // Clerkship Requirements Section
                                SectionView(title: "Clerkship Requirements") {
                                    Text("View Requirements")
                                }
                                // Location Section
                                SectionView(title: "Location") {
                                    Text("View Location Info")
                                }
                            case .resources:
                                ResourcesView()
                            case .search:
                                SearchView()
                            case .profile:
                                ProfileView()
                            }
                        }
                        .padding()
                        
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
    HomeView().environmentObject(FirebaseService())
}
