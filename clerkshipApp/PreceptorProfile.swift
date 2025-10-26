//  PreceptorProfile.swift
//  clerkshipApp

import SwiftUI

struct PreceptorProfile: View {
    private let backgroundColor = Color(red: 0.10, green: 0.26, blue: 0.22)
    private let buttonColor = Color(red: 0.68, green: 0.69, blue: 0.53)
    
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
                            // Add profile picture from firebase ?
                            Circle()
                                // Olive green
                                .fill(buttonColor)
                                .frame(width: 170, height: 170)
                            // Pull from firebase
                            Text("Firstname :")
                                .foregroundColor(.white)
                                .padding(.top, 20)
                                .padding()
                                .bold()
                            
                            Text("Lastname :")
                                .foregroundColor(.white)
                                .padding()
                                .bold()
                            
                            Text("Role :")
                                .foregroundColor(.white)
                                .padding()
                                .bold()
                            
                            Text("Email :")
                                .foregroundColor(.white)
                                .padding()
                                .bold()
                            // Logout button
                            Button(action: {
                                print("Logged Out")
                            }) {
                                Text("Log Out")
                                    .foregroundColor(.white)
                                    .padding()
                                    // Width
                                    .frame(maxWidth: .infinity)
                                    // Olive green color
                                    .background(buttonColor)
                                    .cornerRadius(30)
                            }
                            .padding(.top, 10)
                            // Space around form content
                            .padding()
                        }
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
    PreceptorProfile()
}
