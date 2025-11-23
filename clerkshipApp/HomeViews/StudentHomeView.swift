//
//  StudentHomeView.swift
//  clerkshipApp
//

import SwiftUI

struct StudentHomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    @State private var currentView = NavOption.home
    @StateObject var navControl = NavControl()

    // Allows Eval tab to trigger navigation instead of swapping the whole screen
    @State private var showEvalFromTab = false
    
    @EnvironmentObject var currUser: CurrentUser
    
    // Router object to centralize navigation
    @EnvironmentObject var router: Router
    
    
    var body: some View {
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
