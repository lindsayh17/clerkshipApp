//  ClerkshipRequirementsView.swift
//  clerkshipApp

import SwiftUI

struct ClerkshipRequirementsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser

    @State private var openSection: String? = nil
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Clerkship Requirements")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 40)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        
                        // Attendance & Scheduling
                        section(title: "Attendance & Scheduling") {
                            button("Attendance")
                            button("Rotation Checklist")
                        }
                        
                        // Clinical Rotations
                        section(title: "Clinical Rotations") {
                            button("Obstetrics Service")
                            button("Clinic Service")
                            button("Gyn/Inpatient Service")
                        }
                        
                        // Modules
                        section(title: "Learning Modules") {
                            button("APGO uWise Topics")
                            button("Social Determinants of Health (SDoH)")
                            button("Clinical Reasoning Session")
                            button("RCE Tracker")
                        }
                        
                        // Evaluations
                        section(title: "Evaluations") {
                            button("Mid-Rotation")
                            button("Summative Clerkship Evaluations")
                            button("Exit Interview")
                        }
                        
                        // Exams
                        section(title: "Exams") {
                            button("Shelf Exam Review Session")
                            button("Exams")
                        }
                        
                        // Other
                        section(title: "Other Requirements") {
                            button("Teaching Awards")
                        }
                        
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden()
    }
    
    // Button
    @ViewBuilder
    private func button(_ title: String) -> some View {
        Button(action: {}) {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .background(buttonColor)
                .cornerRadius(12)
        }
    }
    
    // Section Wrapper
    @ViewBuilder
    private func section<Content: View>(title: String,
                                        @ViewBuilder content: @escaping () -> Content) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
                    .rotationEffect(.degrees(openSection == title ? 90 : 0))
                    .animation(.easeInOut, value: openSection == title)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onTapGesture {
                withAnimation(.spring()) {
                    openSection = (openSection == title ? nil : title)
                }
            }
            
            if openSection == title {
                VStack(spacing: 15) {
                    content()
                }
                .padding(.top, 5)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}


// Preview
#Preview {
    NavigationStack {
        ClerkshipRequirementsView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

