//  ClerkshipRequirementsView.swift
//  clerkshipApp

import SwiftUI

struct ClerkshipRequirementsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills the screen
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 5) {
                        // Title
                        Text("Requirements")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                        
                        // Buttons
                        VStack(spacing: 20) {
                            MainButtonView(title: "Attendance", color: buttonColor)
                            MainButtonView(title: "Rotation Checklist", color: buttonColor)
                            MainButtonView(title: "Obstetrics Service", color: buttonColor)
                            MainButtonView(title: "Clinic Service", color: buttonColor)
                            MainButtonView(title: "Gyn/Inpatient Service", color: buttonColor)
                            MainButtonView(title: "APGO uWise Topics", color: buttonColor)
                            MainButtonView(title: "Mid-Rotation", color: buttonColor)
                            MainButtonView(title: "Social Determinants of Health (SDoH)", color: buttonColor)
                            MainButtonView(title: "Clinical Reasoning Session", color: buttonColor)
                            MainButtonView(title: "Summative Clerkship Evaluations", color: buttonColor)
                            MainButtonView(title: "RCE Tracker", color: buttonColor)
                            MainButtonView(title: "Shelf Exam Review Session", color: buttonColor)
                            MainButtonView(title: "Exams", color: buttonColor)
                            MainButtonView(title: "Exit Interview", color: buttonColor)
                            MainButtonView(title: "Teaching Awards", color: buttonColor)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50) // Extra space at the end
                    }
                }
            }
        }
    }
}

// Preview
#Preview {
    ClerkshipRequirementsView()
}

