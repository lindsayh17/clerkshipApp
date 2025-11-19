//  ResourcesView.swift
//  clerkshipApp

import SwiftUI

struct ResourcesView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // State for nav tab
    @State private var currentView: NavOption = .resources
    @State private var showBreastExam = false
    @State private var showLaborTriage = false
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // Title - centered
                        Text("Resources")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        // Buttons
                        VStack(spacing: 20) {
                            MainButtonView(title: "Acronyms", color: buttonColor)
                            MainButtonView(title: "Breast Exam", color: buttonColor) {
                                showBreastExam = true
                            }
                            MainButtonView(title: "Pelvic Exam & Pap Smear", color: buttonColor)
                            MainButtonView(title: "New Patient History", color: buttonColor)
                            MainButtonView(title: "Prenatal-Antepartum Patient", color: buttonColor)
                            MainButtonView(title: "Vaginal Delivery", color: buttonColor)
                            MainButtonView(title: "Labor Triage", color: buttonColor) {
                                showLaborTriage = true
                            }
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
                        .padding(.bottom, 50)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showBreastExam) {
            BreastExamView()
        }
        .navigationDestination(isPresented: $showLaborTriage) {
            LaborTriageView()
        }
    }
}

// Preview
#Preview {
    NavigationStack {
        ResourcesView()
    }
}

