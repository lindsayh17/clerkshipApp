//  StudentProfile.swift
//  clerkshipApp

import SwiftUI

struct ProfileView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @EnvironmentObject var auth: AuthService
    @StateObject var navControl = NavControl()
    
    func signOut(){
        Task{
            do{
                try await auth.signOut()
            }
            catch{
                
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
                                action: {navControl.showRoot = true
                                    signOut()
                                }
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
            }.navigationDestination(isPresented: $navControl.showRoot){RootView()}.navigationBarBackButtonHidden(true)
        }
    }
}

// Preview
#Preview {
    ProfileView().environmentObject(AuthService())
}
