// QuickFactsView.swift
// clerkshipApp

import SwiftUI

struct QuickFactItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct QuickFactsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    // Dropdown state
    @State private var openItem: UUID? = nil
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser

    // Quick Facts data
    private let quickFacts: [QuickFactItem] = [
        QuickFactItem(title: "Orientation",
                      description: "*Full schedule is included in your orientation email General Information/Requirements"),
        QuickFactItem(title: "Social Determinants of Health (SDoH) Session",
                      description: "Session occurs via Zoom on the 5th Friday of your rotation."),
        QuickFactItem(title: "Exit Interview",
                      description: "An exit interview will occur following your final clinical reasoning session at the end of the rotation."),
        QuickFactItem(title: "OBGYN Clinical Services",
                      description: "Obstetrics - care of patients on Labor & Delivery and post-delivery"),
        QuickFactItem(title: "Required Clinical Encounters (RCEs) Tracker",
                      description: "The encounter goals can be found on the Clerkship App and the OBGYN VIC Themes Site."),
        QuickFactItem(title: "On-the-Fly Formative Feedback",
                      description: "UVMMC students will obtain 2 'on the fly' evaluations per week throughout the clerkship."),
        QuickFactItem(title: "Mid-Rotation Feedback (MFR)",
                      description: "This is a mandatory requirement of the LCME."),
        QuickFactItem(title: "APGO Topics / uWise Quizzes",
                      description: "APGO's Medical Student education Objectives cover high-yield OBGYN topics."),
        QuickFactItem(title: "Clinical Reasoning Sessions",
                      description: "At the end of your rotation, you will participate in a formative oral exam."),
        QuickFactItem(title: "Summative Clerkship Evaluations",
                      description: "Summative evaluations reflect your clerkship performance and are compiled to create your final grade and MSPE paragraph."),
        QuickFactItem(title: "Shelf Exam",
                      description: "The NBME shelf exam is administered remotely on the final Friday of your rotation."),
        QuickFactItem(title: "Clinical Skills Exam (CSE)",
                      description: "This occurs during the last week of your rotation."),
        QuickFactItem(title: "Grading",
                      description: "Please see the OBGYN VIC Themes Site for the full policy!"),
        QuickFactItem(title: "Clerkship Absences",
                      description: "For all absences you must complete an LCOM Absence Request Form.")
    ]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Page Title
                        Text("Quick Facts")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 15)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        VStack(spacing: 30) {
                            // Orientation & Intro Section
                            sectionHeader("Orientation & Intro")
                            sectionItems(for: ["Orientation", "Social Determinants of Health (SDoH) Session", "Exit Interview"])
                            
                            // Clinical Activities Section
                            sectionHeader("Clinical Activities")
                            sectionItems(for: ["OBGYN Clinical Services", "Required Clinical Encounters (RCEs) Tracker", "On-the-Fly Formative Feedback", "Mid-Rotation Feedback (MFR)"])
                            
                            // Assessments & Evaluations Section
                            sectionHeader("Assessments & Evaluations")
                            sectionItems(for: ["APGO Topics / uWise Quizzes","Clinical Reasoning Sessions","Summative Clerkship Evaluations","Shelf Exam","Clinical Skills Exam (CSE)","Grading"])
                            
                            // Administrative Section
                            sectionHeader("Administrative")
                            sectionItems(for: ["Clerkship Absences"])
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    }
                }
                // Add bottom navigation bar
                //NavTab(currentTab: $currentView)
            }
            
            // Floating back button
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Section Header
    @ViewBuilder
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.bottom, 5)
    }
    
    // Section Items
    @ViewBuilder
    private func sectionItems(for titles: [String]) -> some View {
        VStack(spacing: 16) {
            ForEach(quickFacts.filter { titles.contains($0.title) }) { item in
                VStack(alignment: .leading, spacing: 8) {
                    // Header Row
                    HStack {
                        Text(item.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white.opacity(0.7))
                            .rotationEffect(.degrees(openItem == item.id ? 90 : 0))
                            .animation(.easeInOut, value: openItem == item.id)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            openItem = (openItem == item.id ? nil : item.id)
                        }
                    }
                    
                    // Expanded Description
                    if openItem == item.id {
                        Text(item.description)
                            .foregroundColor(.white.opacity(0.9))
                            .padding(.horizontal, 10)
                            .padding(.bottom, 12)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }
        }
    }
}


// Preview
#Preview {
    NavigationStack {
        QuickFactsView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
