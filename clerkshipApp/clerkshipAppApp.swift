//
//  clerkshipAppApp.swift
//  clerkshipApp
//
//

import SwiftUI
//import FirebaseCore

@main
struct clerkshipAppApp: App {
    init() {
        // Use Firebase library to configure APIs
        //FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EvaluationView()
        }
    }
}
