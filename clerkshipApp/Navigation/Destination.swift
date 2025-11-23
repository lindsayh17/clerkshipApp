//
//  Destination.swift
//  clerkshipApp
//

import SwiftUI

enum Destination: Identifiable {
    var id: String { "\(self)" }

    case root // initial  screen
    case login
    case register
    case home
    
}

extension Destination: Hashable {
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Destination {
    var screen: AnyView { AnyView(destinationView) }

    private var destinationView: any View {
        switch self {
        case .root:
            return RootView()
        case .login:
            return LoginView()
        case .register:
            return CreateAccountView()
        case .home:
            return HomeView()
            
        }
    }
}
