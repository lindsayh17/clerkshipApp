//  LaborTriageView.swift
//  clerkshipApp

import SwiftUI

struct LaborTriageView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView = Destination.home
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
                        Text("Labor Triage")
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
                            Text("Reviews available patient records\n\nIntroduces self and role\n\nAsks about\n-Contraction onset, strength and frequency\n-Leakage of fluid\n-Vaginal bleeding\n-Fetal movement\n-Last cervical exam, if any\n\nReviews present pregnancy history\n-Any complications?\n-Fetal growth appropriate?\nFetal presentation at last US/SVE?\n\nReviews past pregnancy history\n-Any complications?\n-Mode of delivery?\n-Largest birth weight?\n\nReviews PMH, PSH, Meds, Allergies\n\nReviews Rh and GBS status\n\nReviews FHT and determines category\n\nReviews tocometry\n\nPerforms leopolds for estimated fetal weight and presentation\n\nIs present for SVE and/or SROM check\n\nCreates assessment and plan for patient\n\nWrites triage note")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .background(Color.white.opacity(0.1).cornerRadius(12))
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        Spacer()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
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
        LaborTriageView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}


