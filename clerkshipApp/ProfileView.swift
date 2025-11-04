//  StudentProfile.swift
//  clerkshipApp

import SwiftUI

/*
 TODO: read person info from firebase
 */

struct ProfileView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @EnvironmentObject var auth: AuthService
    @State private var currentView: NavOption = .profile
    @StateObject var navControl = NavControl()
    
    func signOut() {
        Task {
            do {
                try await auth.signOut()
            } catch {
                print("Error signing out")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            // Profile picture
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 170))
                                .padding()
                                .foregroundColor(buttonColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Profile info
                            Group {
                                Text("First Name :")
                                Text("Last Name :")
                                Text("Role :")
                                Text("Email :")
                            }
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.leading, 50)
                            .bold()
                            
                            // Logout button
                            Button(action: {
                                navControl.showRoot = true
                                signOut()
                            }) {
                                Text("Log Out")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(buttonColor)
                                    .cornerRadius(30)
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 50)
                        }
                    }
                    
                    // Bottom navigation
                    NavTab(currentTab: $currentView)
                }
            }
        }
        .navigationDestination(isPresented: $navControl.showRoot) { RootView() }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    ProfileView().environmentObject(AuthService())
}
