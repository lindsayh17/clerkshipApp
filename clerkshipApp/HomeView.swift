//  HomeView.swift
//  clerkshipApp
//

/*
 TODO: daily question styling
 TODO: home page for preceptors
 TODO: nav bar doesn't work with orientation or quick fact pages
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
    // @Binding var destination: HomeDestination
    
    @State private var currentView = NavOption.home
    // State for showing daily question answer
    @State private var showDailyQuestionAnswer = false
    @State private var showLocationInfo = false
    
    @StateObject var navControl = NavControl()
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService
    @EnvironmentObject var qod: QODStore
    
    var body: some View {
        // Single container view
        Group {
            // If user is admin show web dashboard
            if currUser.user?.access == .admin {
                AdminDashboardView()
            } else {
                // Otherwise show normal app content
                NavigationStack {
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
                                                }else {
                                                    Text("No daily question available.")
                                                        .foregroundColor(.white.opacity(0.7))
                                                }
                                            }
                                        }
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
                                                //navControl.showOrientation = true
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom, 50)
                                        .navigationDestination(isPresented: $navControl.showOrientation){OrientationView()}
                                        .navigationDestination(isPresented: $navControl.showQuickFacts){QuickFactsView()}
                                        .navigationDestination(isPresented: $navControl.showRequirements){ClerkshipRequirementsView()}
                                    case .resources:
                                        ResourcesView()
                                    case .search:
                                        SearchView()
                                    case .profile:
                                        ProfileView()
                                    case .users:
                                        SearchView()
                                    case .eval:
//                                        SearchView()
                                        FormChoiceView()
                                    }
                                }
                                .padding()
                            }
                            .padding(.horizontal)
                            // Bottom Navigation
                            NavTab(currentTab: $currentView)
                        }
                        // }
                    }
                }
                .navigationBarBackButtonHidden()
            }
        } // End Group
    }
}

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

// Preview
#Preview {
    HomeView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
        .environmentObject(QODStore())
}

