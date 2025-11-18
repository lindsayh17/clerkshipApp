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
    
    var body: some View {
        VStack {
            // If user is admin show web dashboard
            if currUser.user?.access == .admin {
                AdminDashboardView()
                
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
//                    FormChoiceView()
                    SearchView()
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





// HomeNavCard
struct HomeNavCard: View {
    var title: String
    var icon: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(12)
                    .background(color.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 4)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

struct QODView: View {
    @State private var showDailyQuestionAnswer = false
    @EnvironmentObject var qod: QODStore
    
    var body: some View {
        // Daily Question
        SectionView(title: "Daily Question") {
            VStack(alignment: .leading, spacing: 12) {
                if let dailyQuestion = qod.qod{
                    Text(dailyQuestion.questionText)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .bold()
                Button(action: {
                        withAnimation {
                            // Show answer
                            showDailyQuestionAnswer.toggle()
                        }
                    }) {
                        Text(showDailyQuestionAnswer ? "Hide Answer" : "Show Answer")
                            .underline()
                    }
                    // Answer
                    if showDailyQuestionAnswer {
                        if let dailyAnswer = qod.qod{
                            Text(dailyAnswer.answer)
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    Text("No daily question available.")
                        .foregroundColor(.white.opacity(0.7))
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

