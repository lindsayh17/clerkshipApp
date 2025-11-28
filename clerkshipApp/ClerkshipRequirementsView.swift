//  ClerkshipRequirementsView.swift
//  clerkshipApp

import SwiftUI


struct ClerkshipRequirementsView: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router  // Assuming you have a Router like in OrientationView

    @State private var openSection: String? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Clerkship Requirements")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    // Sections
                    section(title: "Attendance & Scheduling") {
                        MainButtonView(title: "Attendance", color: buttonColor) {
                            router.push(.attendance)
                        }
                        MainButtonView(title: "Rotation Checklist", color: buttonColor)
                    }
                    
                    section(title: "Clinical Rotations") {
                        MainButtonView(title: "Obstetrics Service", color: buttonColor) {
                            router.push(.obstetricService)
                        }
                        MainButtonView(title: "Clinic Service", color: buttonColor) {
                            router.push(.clinicService)
                        }
                        MainButtonView(title: "Gyn/Inpatient Service", color: buttonColor) {
                            router.push(.inpatientGynService)
                        }
                    }
                    
                    section(title: "Learning Modules") {
                        MainButtonView(title: "APGO uWise Topics", color: buttonColor) {
                            router.push(.apgo)
                        }
                        MainButtonView(title: "Social Determinants of Health (SDoH)", color: buttonColor)
                        MainButtonView(title: "Clinical Reasoning Session", color: buttonColor) {
                            router.push(.clinicalReasoning)
                        }
                        MainButtonView(title: "RCE Tracker", color: buttonColor) {
                            router.push(.rce)
                        }
                    }
                    
                    section(title: "Evaluations") {
                        MainButtonView(title: "Mid-Rotation", color: buttonColor) {
                            router.push(.midRotation)
                        }
                        MainButtonView(title: "Summative Clerkship Evaluations", color: buttonColor) {
                            router.push(.summativeClerkship)
                        }
                        MainButtonView(title: "Exit Interview", color: buttonColor)
                    }
                    
                    section(title: "Exams") {
                        MainButtonView(title: "Shelf Exam Review Session", color: buttonColor) {
                            router.push(.shelfExam)
                        }
                        MainButtonView(title: "Exams", color: buttonColor)
                    }
                    
                    section(title: "Other Requirements") {
                        MainButtonView(title: "Teaching Awards", color: buttonColor)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: @escaping () -> Content) -> some View {
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

