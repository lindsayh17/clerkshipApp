//  clerkshipAppApp.swift
//  clerkshipApp


import SwiftUI
import FirebaseCore

@main
struct clerkshipApp: App {
    init() {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RoutingView(router: Router(root: .root))
        }
        .environmentObject(FirebaseService())
        .environmentObject(AuthService())
        .environmentObject(UserStore())
        .environmentObject(CurrentUser())
        .environmentObject(EvalStore())
        .environmentObject(QODStore())
    }
}

