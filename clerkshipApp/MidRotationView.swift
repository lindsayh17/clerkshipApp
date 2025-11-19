//  MidRotationView.swift
//  clerkshipApp

import SwiftUI

struct MidRotationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView = NavOption.home
    // @State var loginManager
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        ZStack (alignment: .topLeading){
            // Fill the screen with background color
            backgroundColor.ignoresSafeArea()
            
            // if currUser.user?.getPrivilege() == .student{
            VStack(spacing: 0) {
                // Scrollable content
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Page title
                        Text("Mid-Rotation")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        }
                        // Description area
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Mid-rotation feedback is a mandatory requirement of the LCME for all students during all clerkships. All clerkships at all sites are required to give formal, face-to-face mid-rotation feedback to all students using a standardized form.\n\nYou will complete the student section of the required form prior to your scheduled meeting. The Coordinator Team will send you a link to the form for you to complete and save before your meeting - plase be sure to only complete the student sections (marked in green).\n\nNote: you and the faculty member will share the 'strengths and areas for improvement' boxes. The same form will be opened and finalized during your mid-rotation meeting. You and the faculty member should submit the completed form together prior to ending your metting.\n\n• Your mid-rotation feedback sessions are generally scheduled around week 3.\n• For UVMMC - These are scheduled with Dr. Morris or Dr. Ruhotina. Scheduled meeting times can be found on the schedule above or individual schedules.\n• For other VT Campus Sites (CVPH, CVMC, Porter & RRMC) - Please reach out to Sara Tourville if you do not know when your meeting is scheduled for at your site.\n• Please remember to have your RCEs Tracker up-to-date, complete the self-assessment portion of the required form, and have your clinical reasoning case selected. Please also email the faculty member in advance to inform them of your case choice.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .background(Color.white.opacity(0.1).cornerRadius(12))
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                }

                NavTab(currentTab: $currentView)
            }
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        MidRotationView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}



