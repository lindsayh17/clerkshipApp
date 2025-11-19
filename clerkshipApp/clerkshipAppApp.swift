//  clerkshipAppApp.swift
//  clerkshipApp


import SwiftUI
import FirebaseCore

@main
struct clerkshipAppApp: App {
//    var firebase = FirebaseService()
    @StateObject var auth = AuthService()

    init() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if auth.isLoggedIn {
                    RootView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(auth)
            .environmentObject(FirebaseService())
            .environmentObject(AuthService())
            .environmentObject(UserStore())
            .environmentObject(CurrentUser())
            .environmentObject(EvalStore())
            .environmentObject(QODStore())
        }
    }
}
