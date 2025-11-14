//  ClerkshipRequirementsView.swift
//  clerkshipApp

/*
 TODO: change format (so it looks different from current)
 TODO: link each button to empty dummy page
 TODO: only display for students
 */

import SwiftUI

struct ClerkshipRequirementsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var navigateHome: Bool = false
    @State private var currentView: NavOption = .home
    @EnvironmentObject var currUser: CurrentUser
    
    private let requirements = [
        "Attendance",
        "Rotation Checklist",
        "Obstetrics Service",
        "Clinic Service",
        "Gyn/Inpatient Service",
        "APGO uWise Topics",
        "Mid-Rotation",
        "Social Determinants of Health (SDoH)",
        "Clinical Reasoning Session",
        "Summative Clerkship Evaluations",
        "RCE Tracker",
        "Shelf Exam Review Session",
        "Exams",
        "Exit Interview",
        "Teaching Awards"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .topLeading) {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            switch currentView {
                            case .home:
                                // Section Title
                                Text("Clerkship Requirements")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top, 20)
                                    .padding(.bottom, 20)
                                    .padding(.horizontal, 40)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .multilineTextAlignment(.center)

                                // Buttons
                                VStack(spacing: 25) {
                                    ForEach(requirements, id: \.self) { title in
                                        Button(action: {
                                        }) {
                                            Text(title)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .padding()
                                                .background(buttonColor)
                                                .cornerRadius(12)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 30)
                                
                            case .resources:
                                ResourcesView()
                            case .search:
                                SearchView()
                            case .profile:
                                ProfileView()
                            case .users:
                                SearchView()
                            case .eval:
                                SearchView()
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    // Bottom NavTab
                    NavTab(currentTab: $currentView)
                }
                BackToHomeButton(navigateHome: $navigateHome)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
            }
            .navigationDestination(isPresented: $navigateHome) {
                HomeView()
                    .transition(.move(edge: .leading))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

// Preview
#Preview {
    ClerkshipRequirementsView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
}

