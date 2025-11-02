//  HomeView.swift
//  clerkshipApp

import SwiftUI

struct HomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @State private var currentView = 1
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fill the screen with background color
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    // Scrollable content
                    ScrollView {
                        VStack(alignment: .leading, spacing: 40) {
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
    HomeView()
}
