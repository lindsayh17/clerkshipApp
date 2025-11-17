//  RootView.swift
//  clerkshipApp

import SwiftUI

struct RootView: View {
    @EnvironmentObject var auth: AuthService
    
    private let backgroundColor = Color("BackgroundColor")
    @StateObject var navControl = NavControl()
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image("GreenUVMLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // Log In button
                BigButtonView(
                    text: "Log In",
                    action: { navControl.showSignIn = true },
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                )
                .padding(.horizontal, 40)
                
                // Create Account button
                BigButtonView(
                    text: "Create Account",
                    action: { navControl.showCreateAccount = true },
                    foregroundColor: backgroundColor,
                    backgroundColor: .white
                )
                .padding(.horizontal, 40)
            }
        }
        // Navigation destinations for buttons
        .navigationDestination(isPresented: $navControl.showSignIn) {
            LoginView()
        }
        .navigationDestination(isPresented: $navControl.showCreateAccount) {
            CreateAccountView()
        }
    }
}

#Preview {
    NavigationStack {  
        RootView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(UserStore())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
    .environmentObject(QODStore())
}

