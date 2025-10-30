//  ResourcesView.swift
//  clerkshipApp

import SwiftUI

struct ResourcesView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills entire screen
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 5) {
                        // Title
                        Text("Resources")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.bottom, 50)
                        
                        // Buttons
                        VStack(spacing: 20) {
                            MainButtonView(title: "Acronyms", color: buttonColor)
                            MainButtonView(title: "Breast Exam", color: buttonColor)
                            MainButtonView(title: "Pelvic Exam & Pap Smear", color: buttonColor)
                            MainButtonView(title: "New Patient History", color: buttonColor)
                            MainButtonView(title: "Prenatal-Antepartum Patient", color: buttonColor)
                            MainButtonView(title: "Vaginal Delivery", color: buttonColor)
                            MainButtonView(title: "Labor Triage", color: buttonColor)
                            MainButtonView(title: "Preeclampsia Triage", color: buttonColor)
                            MainButtonView(title: "Laboring Patient", color: buttonColor)
                            MainButtonView(title: "C-Section", color: buttonColor)
                            MainButtonView(title: "Postpartum Patient/SOAP Note", color: buttonColor)
                            MainButtonView(title: "Operating Room Functionality", color: buttonColor)
                            MainButtonView(title: "Closing Skin Incision - Subcuticular Stitch", color: buttonColor)
                            MainButtonView(title: "Postoperative Check", color: buttonColor)
                            MainButtonView(title: "Postop Visit - Morning Rounds", color: buttonColor)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50) // Extra space at the bottom
                    }
                }
            }
        }
    }
}

#Preview {
    ResourcesView()
}

