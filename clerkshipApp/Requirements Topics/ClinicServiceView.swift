//  ClinicServiceView.swift
//  clerkshipApp

import SwiftUI

struct ClinicServiceView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView = Destination.home
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
                        Text("Clinic Service")
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
                            Text("The clinic experience varies slightly from site to site. But all sites during clinic, students should do the folowing.\n\n• Dress in business casual attire and wear your white coat and your badge. No open toed shoes.\n• Go to a variety of clinics (if applicable) and see low risk ob patients, high risk ob patients, ob us, gyn us, oncology patients, infertility patients, urogyn patients, general gyn patients, colposcopy, etc.\n• Try to  avoid being in the same clinic as another medical student, NP student or PA student.\n• In clinic you should practice taking histories, doing general exams, presenting patients, doing breast and pelvic exams with speculums and pap smears.\n• You Should observe bedside manner, patient education, informed consent.")
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

//                NavTab(currentTab: $currentView)
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
        ClinicServiceView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}
