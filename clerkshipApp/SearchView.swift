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
                    
                    // Bottom white transparent nav bar
                    ZStack {
                        // Color + rounded corners
                        Color.white
                            // Transparency
                            .opacity(0.6)
                            .cornerRadius(35)
                            .frame(height: 90)
                            // Side spacing
                            .padding(.horizontal, 25)
                            // Bottom spacing
                            .padding(.bottom, 10)
                        
                        // Feedback & Profile buttons
                        HStack(spacing: 60) {
                            // Feedback button
                            VStack {
                                Circle()
                                    // Olive green
                                    .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .frame(width: 50, height: 50)
                                Text("Feedback")
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                            
                            // Profile button
                            VStack {
                                Circle()
                                    // Olive green
                                    .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                                    .frame(width: 50, height: 50)
                                Text("Profile")
                                    .foregroundColor(.black)
                                    .padding(.top, 4)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
