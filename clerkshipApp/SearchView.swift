//  SearchView.swift
//  clerkshipApp

import SwiftUI

struct SearchView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
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
                    NavView()
                }
            }
        }
    }
}

// Preview
#Preview {
    SearchView()
}

