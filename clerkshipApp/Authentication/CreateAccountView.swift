//  LoginView.swift
//  clerkshipApp

/*
 TODO: fix text color so more visible
 TODO: back/cancel button
 TODO: hide navigation back button once in HomeView
 TODO: make text fields and error messages look better
 */

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @State private var email = ""
    @State private var password = ""
    @State private var firstname = ""
    @State private var lastname = ""
    // To HomeView
    @State private var navigateToHome: Bool = false
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func createAccount() {
        Task {
            do {
                try await auth.createAccount(email: email, password: password)
                try await auth.createUser(fname: firstname, lname: lastname, email: email)
                // Mark user as signed in
                auth.isLoggedIn = true
                // Navigate to HomeView
                navigateToHome = true
            } catch {
                print("Error creating account")
            }
        }
    }
    
    func checkComplete() -> Bool{
        if email != "" && firstname != "" && lastname != ""{
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        if !auth.isLoggedIn {
            ZStack {
                // Color fills the entire screen
                backgroundColor.ignoresSafeArea()
                VStack {
                    Image("GreenUVMLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Create Account")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350, height: 100, alignment: .bottomLeading)
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
                
                BigButtonView(
                    text: "Create Account",
                    action: createAccount,
                    foregroundColor: .white,
                    backgroundColor: backgroundColor,
                    disabled: !checkComplete()
                )
            }
            .padding()
        } else {
            HomeView()
        }
    }
}

// Preview
#Preview {
    // TODO: it's fine if we want these now, but should take out later
    CreateAccountView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
