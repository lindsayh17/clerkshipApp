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
//    private let buttonColor = Color("ButtonColor")
    
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
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
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
                BigButtonView(buttonText: "Log In", action: signin, foregroundColor: .white, backgroundColor: backgroundColor)
                    
            }
            .padding()
        }
    }
}

struct BigButtonView: View {
    var buttonText: String = ""
    var action: () -> Void
    var width: CGFloat = 300
    var height: CGFloat = 60
    var foregroundColor = Color.white
    var backgroundColor = Color.accentColor
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .border(.white, width: 5)
                .foregroundColor(foregroundColor) .background(backgroundColor) .overlay(RoundedRectangle(cornerRadius: 5)
                          .stroke(Color.black, lineWidth: 2))
                        .cornerRadius(5)
        }
        .padding()
    }
}

// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
        .environmentObject(AuthService())
}
