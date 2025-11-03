//
//  RootView.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 10/30/25.
//

import SwiftUI

struct RootView: View {
    private let backgroundColor = Color("BackgroundColor")
    @StateObject var navControl = NavControl()
    
    var body: some View {
        NavigationStack{
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    // TODO: put logo here
                    Image("clerkshipAppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("OBGYN Clerkship")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350, height: 100, alignment: .bottomLeading)
                        .padding()
                    
                    // log in button
                    BigButtonView(
                        text: "Log In",
                        action: {navControl.showSignIn = true},
                        foregroundColor: .white,
                        backgroundColor: backgroundColor
                    ).padding()
                    
                    // create account button
                    BigButtonView(
                        text: "Create Account",
                        action: {navControl.showCreateAccount = true},
                        foregroundColor: backgroundColor,
                        backgroundColor: .white
                    ).padding()
                    
                }
            }.navigationDestination(isPresented: $navControl.showSignIn){ LoginView()}
                .navigationDestination(isPresented: $navControl.showCreateAccount){ CreateAccountView()}
                .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    RootView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
