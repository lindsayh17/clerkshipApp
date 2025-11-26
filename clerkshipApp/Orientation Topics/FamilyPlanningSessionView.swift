//  FamilyPlanningSessionView.swift
//  clerkshipApp

import SwiftUI

struct FamilyPlanningSessionView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @State private var currentView = Destination.home
    // @State var loginManager
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var auth: AuthService
    
    var body: some View {
        ZStack (alignment: .topLeading) {
            // Fill the screen with background color
            backgroundColor.ignoresSafeArea()
            
            // if currUser.user?.getPrivilege() == .student{
            VStack(spacing: 0) {
                // Scrollable content
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Page title
                        Text("Family\n Planning Sessions")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)

                        // Buttons Section
                        Button(action: {
                        // do something for Pregnancy Counseling
                        }) {
                            Text("Pregnancy Counseling")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonColor)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }

                        Button(action: {
                        // do something for Family Planning Presentation
                        }) {
                            Text("Family Planning Presentation")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonColor)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }

                        // Description area
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Prior to orientation day you are required to read the Pregnancy Counseling document. The Global Abortion Information is optional reading.\n\nYou will being the session with a short survey\n\nThe goals for this session are:\n• Learn how abortion fits into ob/gyn training and clinical practice\n• Briefly review medical management of abortion: medications and procedires used, possible complications of abortions and isues of fetal viability\n• Discuss abortion regulation and recent changes, locally and nationally\n• Improve your comfort in discussing abortion with patients, colleagues and others")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                            Text("All abortion training/exposure is optional - we fully support students who opt not to participate in these procedures.")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.top, 10)

                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
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
        FamilyPlanningSessionView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}



