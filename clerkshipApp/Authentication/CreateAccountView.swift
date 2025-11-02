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
    @State private var firstname = ""
    @State private var lastname = ""
    
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
        
        // TODO: put in a task?
        auth.createUser(fname: firstname, lname: lastname, email: email)
    }
    
    var body: some View {
        VStack {
            // Color fills the entire screen
            // backgroundColor.ignoresSafeArea()
            TextField("First name...", text: $firstname)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            TextField("Last name...", text: $lastname)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            
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
            BigButtonView(
                text: "Create Account",
                action: createAccount,
                foregroundColor: .white,
                backgroundColor: backgroundColor
            )
        }
        .padding()
    }
}

// Preview
#Preview {
    CreateAccountView()
}
