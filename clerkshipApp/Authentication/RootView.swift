//  RootView.swift
//  clerkshipApp

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var router: Router
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
                    action: { router.push(.login)},
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                )
                .padding(.horizontal, 40)
                
                // Create Account button
                BigButtonView(
                    text: "Create Account",
                    action: { router.push(.register) },
                    foregroundColor: backgroundColor,
                    backgroundColor: .white
                )
                .padding(.horizontal, 40)
                
            }
//            .navigationTitle("Login")
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

