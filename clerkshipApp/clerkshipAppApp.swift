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
            RootView()
                .environmentObject(FirebaseService())
                .environmentObject(AuthService()).environmentObject(UserStore()).environmentObject(CurrentUser())
        }
    }
}
