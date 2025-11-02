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
    
    func checkComplete() -> Bool{
        if email != "" && firstname != "" && lastname != ""{
            return true
        }else{
            return false
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
                Text("Create Account")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 350, height: 100, alignment: .bottomLeading)
                    .padding()
            }
        }
        VStack {
            TextField("First name...", text: $firstname)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            TextField("Last name...", text: $lastname)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
            
            TextField("Email...", text: $email)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
                .textInputAutocapitalization(.never)
            // TODO: remove password
            SecureField("Password...", text: $password)
                .padding()
                .cornerRadius(10)
                .background(Color.gray.opacity(0.4))
                .textInputAutocapitalization(.never)
            
            if auth.errorMessage != nil{
                Text(auth.errorMessage)
            }
            
            // TODO: add navigation if sign in successful
            BigButtonView(
                text: "Create Account",
                action: createAccount,
                foregroundColor: .white,
                backgroundColor: backgroundColor,
                disabled: !checkComplete()
            )
        }
        .padding()
    }
}

// Preview
#Preview {
    CreateAccountView()
}
