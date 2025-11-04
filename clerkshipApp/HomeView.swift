//  HomeView.swift
//  clerkshipApp

/*
 TODO: change display options for students vs. preceptors
 TODO: send each link to a dummy page
 */

import SwiftUI

struct HomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @State private var currentView = NavOption.home
    // @State var loginManager
    // Daily question
    // TODO : Fetch questions from firebase
    @State private var dailyQuestion = "What is the most common cause of postoperative fever within 24 hours?"
    // State for showing daily question answer
    @State private var showDailyQuestionAnswer = false
    
    var body: some View {
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
                                // Daily Question
                                SectionView(title: "Daily Question") {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(dailyQuestion)
                                            .foregroundColor(.white)
                                            .font(.title3)
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
                                            Text("Atelectasis")
                                                .foregroundColor(.white)
                                        }
                                        
                                    }
                                }
                                // Quick Facts Section
                                SectionView(title: "Quick Facts") {
                                    Text("View Quick Facts")
                                        .font(.title3)
                                        .bold()
                                }
                                // Orientation Section
                                SectionView(title: "Orientation") {
                                    Text("View Orientation Details")
                                        .font(.title3)
                                        .bold()
                                }
                                // Clerkship Requirements Section
                                SectionView(title: "Clerkship Requirements") {
                                    Text("View Requirements")
                                        .font(.title3)
                                        .bold()
                                }
                                // Location Section
                                SectionView(title: "Location") {
                                    Text("View Location Info")
                                        .font(.title3)
                                        .bold()
                                }
                            case .resources:
                                ResourcesView()
                            case .search:
                                SearchView()
                            case .profile:
                                ProfileView()
                            }
                        }
                        .padding()
                        
                    }.padding()
                    // Bottom Navigation
                    NavTab(currentTab: $currentView)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

// Preview
#Preview {
    HomeView().environmentObject(FirebaseService())
}
