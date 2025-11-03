//
//  LoginView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//
// username: lhall11@uvm.edu
// password: 123456
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @State private var email = ""
    @State private var password = ""
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    // Firebase Download
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Color fills the entire screen
            backgroundColor.ignoresSafeArea()
            VStack {
                Image("clerkshipAppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                Text("Welcome Back")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 350, height: 100, alignment: .bottomLeading)
                    .padding()
            }
        }
        VStack {
            // TODO: email validation
            // TODO: remove autocapitilization
            TextField("Email...", text: $email)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
                .textInputAutocapitalization(.never)
                .foregroundColor(.white)
            
            SecureField("Password...", text: $password)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
                .textInputAutocapitalization(.never)
                .foregroundColor(.white)
            
            // TODO: add navigation if sign in successful
            BigButtonView(
                text: "Log In",
                action: signin,
                foregroundColor: .white,
                backgroundColor: backgroundColor
            ).padding()
                
        }
        .padding()
        
    }
}


// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
