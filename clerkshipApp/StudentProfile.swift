//  StudentProfile.swift
//  clerkshipApp

import SwiftUI

struct StudentProfile: View {
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
                            // Add profile picture from firebase ?
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 170))
                                .padding()
                                .foregroundColor(buttonColor)
                            
                            // Pull from firebase
                            Text("First Name :")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.top, 20)
                                .padding(.leading, 50)
                                .bold()
                            
                            Text("Last Name :")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.leading, 50)
                                .bold()
                            
                            Text("Role :")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.leading, 50)
                                .bold()
                            
                            Text("Email :")
                                .foregroundColor(.white)
                                .font(.title2)
                                .padding(.leading, 50)
                                .bold()
                            
                            // Logout button
                            Button(
                                action: {print("Logged Out")}
                            ) {
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
                }
            }
        }
    }
}

// Preview
#Preview {
    StudentProfile()
}
