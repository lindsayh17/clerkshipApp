//  SearchView1.swift
//  clerkshipApp

import SwiftUI

struct SearchView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @State private var currentView = NavOption.home
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Color fills the entire screen
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    // Add search bar
                    // Makes scrollable
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            // Add A-# on left side going down
                            // Take names from firebase and sort alphabetically
                        }
                        // Space around form content
                        .padding()
                    }
                    // Bottom Navigation Bar
                    NavTab(currentTab: $currentView)
                }
            }
        }
    }
}

// Preview
#Preview {
    SearchView()
        .environmentObject(CurrentUser())
}

