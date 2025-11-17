//  RCEView.swift
//  clerkshipApp

import SwiftUI

struct RCEView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    // @Binding var destination: HomeDestination
    
    @State private var navigateRequirements: Bool = false
    
    @State private var currentView = NavOption.home
    // @State var loginManager
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
                        Text("Required\n Clinical Encounters (RCE) Tracker")
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
                            // Buttons Section
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("RCE Tracker Checklist")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            }
                            Text("The required clinical encounters tracker will be used to track your patient interactions and RCEs goals. The Clerkship App holds a list of the trackable encounters that should be entered.\n\nSDoH - Please check this box for any encounter you log if you feel that social drivers of health played an important role in the patient's care. Then note (on the description box) 1-2 social driver(s) that most impacted their care.\n\nImportant Information\nSubmissions should be entered along the way as the system has a 2 week rolling entry window. You will not be able to enter interactions further than 2 weeks back from the day of entry.\n\nOne patient encounter can be used to meet numerous tracker requirements.\n\nReview your tracker at mid-rotation to make sure you are on track to meet the required experiences.\n\nCompletion Requirement\nThe Larner College of Medicine requires a fully completed tracker and it is the expectation that you supplement any missed experiences with another learning activity to meet that requirement.\n\nPlease use the list of alternative experiences to log any tracker requirement that you missed during your orientation simulation activities, pelvic & breast refresher and/or CSE or by completing the corresponding APGO topic in your mandatory uWise requirement.\n\nNo more than 25% of the tracker can be met by alternative experiences.\n\nTo list an alternative experience in the tracker please use XXX for initials and indicate the work you completed for the requirement(APGO questions/cases, simulation, refresher, CSE, etc.)\n\nIf your tracker is incomplete at the time of grade submission you will receive a final grade of INCOMPLETE until the tracker is fully compelted.")
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
            ClerkshipRequirementsButtonView(navigateRequirements: $navigateRequirements)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationDestination(isPresented: $navigateRequirements) {
            ClerkshipRequirementsView()
                .transition(.move(edge: . leading))
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        RCEView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

