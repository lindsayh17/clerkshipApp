//  AdminProfile.swift
//  clerkshipApp

import SwiftUI

struct AdminProfile: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @EnvironmentObject var auth: AuthService
    
    func getUserInfo(){
        Task {
            do {
                if let user = try await auth.fetchCurrentUser() {
                } else {
                    print("No user found.")
                }
            } catch {
                print("Error fetching current user: \(error)")
            }
        }
    }
    
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

                            Text("Firstname : ")
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
                }.padding()
            }
        }
    }
}

// Preview
#Preview {
    AdminProfile().environmentObject(AuthService())
}
