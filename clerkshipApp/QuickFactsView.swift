//  QuickFactsView.swift
//  clerkshipApp

import SwiftUI

struct QuickFactItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct QuickFactsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    // State for nav tab
    @State private var currentView: NavOption = .resources
    
    // Quick Facts data
    private let quickFacts: [QuickFactItem] = [
        QuickFactItem(title: "Orientation",
                      description: "*Full schedule is included in your orientation email General Information/Requirements"),
        QuickFactItem(title: "OBGYN Clinical Services",
                      description: "Obstetrics - care of patients on Labor & Delivery and post-delivery"),
        QuickFactItem(title: "APGO Topics / uWise Quizzes",
                      description: "APGO's Medical Student education Objectives cover high-yield OBGYN topics."),
        QuickFactItem(title: "On-the-Fly Formative Feedback",
                      description: "UVMMC students will obtain 2 'on the fly' evaluations per week throughout the clerkship."),
        QuickFactItem(title: "Mid-Rotation Feedback (MFR)",
                      description: "This is a mandatory requirement of the LCME."),
        QuickFactItem(title: "Required Clinical Encounters (RCEs) Tracker",
                      description: "The encounter goals can be found on the Clerkship App and the OBGYN VIC Themes Site."),
        QuickFactItem(title: "Clinical Reasoning Sessions",
                      description: "At the end of your rotation, you will participate in a formative oral exam."),
        QuickFactItem(title: "Summative Clerkship Evaluations",
                      description: "Summative evaluations reflect your clerkship performance and are compiled to create your final grade and MSPE paragraph."),
        QuickFactItem(title: "Social Determinants of Health (SDoH) Session",
                      description: "Session occurs via Zoom on the 5th Friday of your rotation."),
        QuickFactItem(title: "Shelf Exam",
                      description: "The NBME shelf exam is administered remotely on the final Friday of your rotation."),
        QuickFactItem(title: "Clinical Skills Exam (CSE)",
                      description: "This occurs during the last week of your rotation."),
        QuickFactItem(title: "Exit Interview",
                      description: "An exit interview will occur following your final clinical reasoning session at the end of the rotation."),
        QuickFactItem(title: "Clerkship Absences",
                      description: "For all absences you must complete an LCOM Absence Request Form."),
        QuickFactItem(title: "Grading",
                      description: "Please see the OBGYN VIC Themes Site for the full policy!")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Title - centered
                            Text("Quick Facts")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 30)
                                .padding(.bottom, 15)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            // Quick Facts list - left aligned
                            VStack(alignment: .leading, spacing: 25) {
                                ForEach(quickFacts) { item in
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(item.title)
                                            .font(.title)
                                            .foregroundColor(.white)
                                        
                                        Text(item.description)
                                            .font(.body)
                                            .foregroundColor(.white.opacity(0.85))
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                        }
                    }
                    
                    // Bottom Navigation
                    NavTab(currentTab: $currentView)
                }
            }
        }
    }
}

// Preview
#Preview {
    QuickFactsView()
}
