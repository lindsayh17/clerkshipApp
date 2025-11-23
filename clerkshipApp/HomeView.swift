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
    @EnvironmentObject var qod: QODStore
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            // If user is admin show web dashboard
            if currUser.user?.access == .admin {
                AdminDashboardView()
                
            } else if currUser.user?.access == .preceptor {
                // Preceptor view inside HomeView
                ZStack {
                    backgroundColor.ignoresSafeArea()
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 40) {
                                switch currentView {
                                case .home:
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Welcome, \(currUser.user?.firstName ?? "Preceptor")")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    
                                case .resources:
                                    ResourcesView()
                                    
                                case .search:
                                    SearchView()
                                    
                                case .profile:
                                    ProfileView()
                                    
                                case .users:
                                    SearchView()
                                    
                                case .eval:
                                    EmptyView() 
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        
                        // Bottom Navigation
                        NavTab(currentTab: $currentView)
                            .onChange(of: currentView) { newTab in
                                if newTab == .eval {
                                    showEvalFromTab = true
                                    currentView = .home
                                }
                            }
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $navControl.showEvalChoice) {
                    SearchView() // or another view if needed
                }
                .navigationDestination(isPresented: $showEvalFromTab) {
                    if let curr = currUser.user {
                        FormChoiceView(currStudent: curr) // probably preceptors won't use this
                    }
                }
                .navigationDestination(isPresented: $navControl.showOrientation) {
                    OrientationView()
                }
                .navigationDestination(isPresented: $navControl.showQuickFacts) {
                    QuickFactsView()
                }
                .navigationDestination(isPresented: $navControl.showRequirements) {
                    ClerkshipRequirementsView()
                }

            } else {
                // Otherwise show normal app content
                ZStack {
                    // Fill the screen with background color
                    backgroundColor.ignoresSafeArea()
                    VStack(spacing: 0) {
                        // Scrollable content
                        ScrollView {
                            VStack(alignment: .leading, spacing: 40) {
                                switch currentView {
                                case .home:
                                    HStack{
                                        VStack(alignment: .leading, spacing: 4){
                                            Text("Welcome, \(currUser.user?.firstName ?? "Student")")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        Spacer()
                                    }
                                    // Daily Question
                                    QODView()
                                    
                                    VStack(spacing: 20) {
                                        HomeNavCard(title: "Quick Facts", icon: "book.fill", color: .purple) {
                                            navControl.showQuickFacts = true
                                        }
                                        
                                        HomeNavCard(title: "Orientation", icon: "figure.wave", color: .teal) {
                                            navControl.showOrientation = true
                                        }
                                        
                                        HomeNavCard(title: "Clerkship Requirements", icon: "checkmark.seal.fill", color: .pink) {
                                            navControl.showRequirements = true
                                        }
                                        
                                        HomeNavCard(title: "Evaluation Form", icon: "doc.text.fill", color: .orange) {
                                            navControl.showEvalChoice = true
                                        }
                                        
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 50)
                                    
                                case .resources:
                                    ResourcesView()
                                    
                                case .search:
                                    SearchView()
                                    
                                case .profile:
                                    ProfileView()
                                    
                                case .users:
                                    SearchView()
                                    
                                case .eval:
                                    // Do not show FormChoiceView here anymore, eval tab now triggers a navigation push instead of replacing the screen so formatting doesn't get messed up
                                    EmptyView()
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        
                        // Bottom Navigation
                        NavTab(currentTab: $currentView)
                            .onChange(of: currentView) { newTab in
                                if newTab == .eval {
                                    showEvalFromTab = true
                                    // Return to a "neutral" tab visually
                                    currentView = .home
                                }
                            }
                    }
                }
                .navigationBarBackButtonHidden()

                // NAVIGATION DESTINATIONS

                // Eval via Home card
                .navigationDestination(isPresented: $navControl.showEvalChoice) {
//                    FormChoiceView()
                    SearchView()
                }
                // Eval via bottom tab
                .navigationDestination(isPresented: $showEvalFromTab) {
                    if let curr = currUser.user{
                        FormChoiceView(currStudent: curr)
                    }
                }
                // Other destinations
                .navigationDestination(isPresented: $navControl.showOrientation) {
                    OrientationView()
                }
                .navigationDestination(isPresented: $navControl.showQuickFacts) {
                    QuickFactsView()
                }
                .navigationDestination(isPresented: $navControl.showRequirements) {
                    ClerkshipRequirementsView()
                }
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

