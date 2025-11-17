//  clerkshipAppApp.swift
//  clerkshipApp


import SwiftUI
import FirebaseCore

@main
struct clerkshipAppApp: App {
//    var firebase = FirebaseService()

    init() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(FirebaseService())
            .environmentObject(AuthService())
            .environmentObject(UserStore())
            .environmentObject(CurrentUser())
            .environmentObject(EvalStore())
            .environmentObject(QODStore())          
        }
    }
}
