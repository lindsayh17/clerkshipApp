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
                                .background(Color(red: 0.68, green: 0.69, blue: 0.53))
                                .cornerRadius(30)
                        }
                        .padding(.top, 10)
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
    PreceptorProfile()
}
