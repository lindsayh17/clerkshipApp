//  clerkshipAppApp.swift
//  clerkshipApp


import SwiftUI
import FirebaseCore

@main
struct clerkshipAppApp: App {
    @StateObject var authService = AuthService()
    @StateObject var firebaseService = FirebaseService()
    @StateObject var userStore = UserStore()
    @StateObject var currentUser = CurrentUser()
    @StateObject var evalStore = EvalStore()
    @StateObject var qodStore = QODStore()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(authService)
            .environmentObject(firebaseService)
            .environmentObject(userStore)
            .environmentObject(currentUser)
            .environmentObject(evalStore)
            .environmentObject(qodStore)
        }
    }
}

