//
//  LoginView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//
// username: lhall11@uvm.edu
// password: 123456
//
/*
 TODO: back/cancel button
 TODO: hide navigation back button
 TODO: make errors look better
 */

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var userStore: UserStore
    @State private var email = ""
    @State private var password = ""
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    func getNames() {
        Task{
            do {
                // Fetch users directly
                try await firebase.fetchUsers()
                if firebase.downloadSuccessful{
                    for user in firebase.users{
                        userStore.addUser(user)
                    }
                }
            } catch {
                print("Error fetching users: \(error)")
            }
        }
    }
    
    // Firebase Download
    func signin() {
        Task {
            do {
                try await auth.signIn(email: email, password: password)
                getNames()
                auth.isLoggedIn = true
            }
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
                    Text("Welcome Back")
                        .font(.system(size: 36))
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350, height: 100, alignment: .leading)
                }
            }
            VStack {
                TextField("Email...", text: $email)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                
                SecureField("Password...", text: $password)
                    .padding()
                    .cornerRadius(10)
                    .background(Color.gray.opacity(0.4))
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                
                BigButtonView(
                    text: "Log In",
                    action: signin,
                    foregroundColor: .white,
                    backgroundColor: backgroundColor
                ).padding()
                
            }
            .padding()
        } else {
            HomeView()
        }
        
    }
}


// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
        .environmentObject(AuthService()).environmentObject(UserStore())
}
