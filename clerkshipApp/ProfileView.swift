//  StudentProfile.swift
//  clerkshipApp

import SwiftUI

struct ProfileView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var currUser: CurrentUser
    
    @Environment(\.dismiss) var dismiss
    
    func signOut() {
        Task {
            do {
                try await auth.signOut()
                router.switchRoot(.root)
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
                    VStack(alignment: .leading, spacing: 20) {
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
                        
                        // create button so students can see their evals
                        if let user = currUser.user {
                            if user.access == .student {
                                Button {
                                    router.push(.seeEval)
                                } label: {
                                    HStack {
                                        Image(systemName: "doc.text.fill")
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .padding(12)
                                            .background(.orange.opacity(0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        
                                        Text("Completed Evaluations")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        
                        // Logout button
                        MainButtonView(
                            title: "Log Out",
                            color: .button.opacity(0.8),
                            action: {
                                signOut()
                            })
                        .padding(.bottom, 30)
                        .padding(.horizontal, 40)
                    }
                }
                NavTab(currView: .profile)
            }
        }
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

