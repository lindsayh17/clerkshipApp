//  HomeView.swift
//  clerkshipApp

import SwiftUI
import WebKit

enum HomeDestination {
    case dailyQuestion
    case quickFacts
    case orientation
    case clerkshipReqs
    case location
}

struct HomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let cardColor = Color("CardColor")
    private let accentColor = Color("AccentColor")
    
//    @State private var currentView = Destination.home
    @State private var showDailyQuestionAnswer = false
    @State private var showLocationInfo = false
    
    // Allows Eval tab to trigger navigation instead of swapping the whole screen
    @State private var showEvalFromTab = false
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService
    
    // Router object to centralize navigation
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                // If user is admin show web dashboard
                if currUser.user?.access == .admin {
                    AdminDashboardView()
                    
                } else if currUser.user?.access == .preceptor {
                    PreceptorHomeView()
                    
                } else {
                    StudentHomeView()
                }
                NavTab(currView: .home)
            }
        }
    }
}


// Preview
#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
    .environmentObject(Router(root: .home))
    .environmentObject(QODStore())
}
