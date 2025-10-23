//  PreceptorProfile.swift
//  clerkshipApp

import SwiftUI

struct PreceptorProfile: View {
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
                        // Add profile picture from firebase ?
                        Circle()
                        // Olive green
                        .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                        .frame(width: 170, height: 170)
                        // Add first + last name, email and role
                        // Submit button
                        Button(action: {
                            print("Logged Out")
                        }) {
                            Text("Log Out")
                                .foregroundColor(.white)
                                .padding()
                                // Width
                                .frame(maxWidth: .infinity)
                                // Olive green color
                                .background(Color(red: 0.68, green: 0.69, blue: 0.53))
                                .cornerRadius(30)
                        }
                        .padding(.top, 10)
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
    PreceptorProfile()
}
