//
//  LoginView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var auth: AuthService
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Firebase Download
    func download() {
        Task {
            do {
                try await firebase.fetchUsers()
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Color fills the entire screen
            backgroundColor.ignoresSafeArea()
            
            
        }
    }
}

// Preview
#Preview {
    LoginView().environmentObject(FirebaseService())
}
