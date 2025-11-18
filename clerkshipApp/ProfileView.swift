//  StudentProfile.swift
//  clerkshipApp

import SwiftUI

struct ProfileView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var currUser: CurrentUser
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
                        if let current = currUser.user{
                            Group {
                                Text("First Name : \(current.firstName)")
                                Text("Last Name : \(current.lastName)")
                                switch current.access {
                                case .student:
                                    Text("Role : Student")
                                case .preceptor:
                                    Text("Role : Preceptor")
                                case .admin:
                                    Text("Role : Administrator")
                                }
                                Text("Email : \(current.email)")
                            }
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.leading, 50)
                            .bold()
                        }
                        
                        // Logout button
                        Button(action: {
                            //navControl.showRoot = true
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
                
            }
        }
    .navigationDestination(isPresented: $navControl.showRoot) { RootView() }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        ProfileView()
    }
    .environmentObject(AuthService())
    .environmentObject(CurrentUser())
}
