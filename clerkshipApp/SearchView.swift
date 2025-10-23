//  SearchView.swift
//  clerkshipApp

import SwiftUI

struct SearchView: View {
    // State variables to track user answers
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color (dark green)
                Color(red: 0.10, green: 0.26, blue: 0.22)
                // Color fills the entire screen
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Add search bar
                    // Makes scrollable
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                        }
                        // Add A-# on left side going down
                        // Take names from firebase and but alphabetically in
                        // Space around form content
                        .padding()
                    }
                    
                    NavView()

                }
            }
        }
    }
}

#Preview {
    SearchView()
}
