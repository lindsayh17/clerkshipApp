//
//  PreceptorHomeView.swift
//  clerkshipApp
//

import SwiftUI

struct PreceptorHomeView: View {
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
    }
}
