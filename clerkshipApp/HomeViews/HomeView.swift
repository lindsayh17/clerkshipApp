//  HomeView.swift
//  clerkshipApp
//

/*
 TODO: daily question styling
 TODO: home page for preceptors
 */

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
    
    @State private var currentView = NavOption.home
    @State private var showDailyQuestionAnswer = false
    @State private var showLocationInfo = false
    
    @StateObject var navControl = NavControl()

    // Allows Eval tab to trigger navigation instead of swapping the whole screen
    @State private var showEvalFromTab = false
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService
    
    // Router object to centralize navigation
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            // If user is admin show web dashboard
            if currUser.user?.access == .admin {
                AdminDashboardView()
                
            } else if currUser.user?.access == .preceptor {
                PreceptorHomeView()
                
            } else {
                StudentHomeView()
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
    .environmentObject(QODStore())
}
