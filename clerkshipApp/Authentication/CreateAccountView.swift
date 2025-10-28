//
//  LoginView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/28/25.
//
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @State private var email = ""
    @State private var password = ""
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func createAccount() {
        Task {
            do {
                try await auth.createAccount(email: email, password: password)
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
            Button(action: createAccount, label: {
                Text("Create Account")
            })
        }
        .padding()
    }
}

// Preview
#Preview {
    CreateAccountView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
