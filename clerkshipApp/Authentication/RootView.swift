//  RootView.swift
//  clerkshipApp

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var router: Router
    @StateObject var navControl = NavControl()
    private let backgroundColor = Color("BackgroundColor")

    
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
                    action: {
                        router.push(.login)
                        navControl.showSignIn = true
                    },
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                )
                .padding(.horizontal, 40)
                
                // Create Account button
                BigButtonView(
                    text: "Create Account",
                    action: {
                        router.push(.register)
                        navControl.showCreateAccount = true
                    },
                    foregroundColor: backgroundColor,
                    backgroundColor: .white
                )
                .padding(.horizontal, 40)
                
            }
        }
        .onAppear {
            navControl.showRoot = true
            navControl.showSignIn = false
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
    RootView()
        .environmentObject(Router(root: .root))
        .environmentObject(FirebaseService())
        .environmentObject(UserStore())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
        .environmentObject(QODStore())
}

