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
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
            }
        }
    }
    
    var body: some View {
        VStack {
            // Color fills the entire screen
            // backgroundColor.ignoresSafeArea()
            
            // TODO: email validation
            // TODO: remove autocapitilization
            TextField("Email...", text: $email)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            SecureField("Password...", text: $password)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            
            // TODO: add navigation if sign in successful
            Button(action: signin, label: {
                Text("Sign In")
            })
        }
        .padding()
    }
}

// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
