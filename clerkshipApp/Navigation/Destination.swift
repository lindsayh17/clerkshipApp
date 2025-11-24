//
//  Destination.swift
//  clerkshipApp
//

import SwiftUI

enum Destination: Identifiable {
    var id: String { "\(self)" }

    // auth screens
    case root
    case login
    case register
    
    // main app
    case home
    case quickFacts
    case orientation
    case requirements
    
    // nav tab
    case resources
    case search
    case users
    case profile
    
    case evalChoice // eval
    case eval
    
}

extension Destination: Hashable {
    // overloaded operator
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
            // auth views
        case .root:
            return RootView()
        case .login:
            return LoginView()
        case .register:
            return CreateAccountView()
            
            // main app views
        case .home:
            return HomeView()
        case .quickFacts:
            return QuickFactsView()
        case .orientation:
            return OrientationView()
        case .requirements:
            return ClerkshipRequirementsView()
            
            // nav tab options
        case .resources:
            return ResourcesView()
        case .search:
            return SearchView()
        // TODO: this could take you to the profile of each user
        case .users:
            return SearchView()
        case .profile:
            return ProfileView()
        case .evalChoice:
            return EmptyView()

        case .eval:
            return EmptyView()
        }
    }
}
