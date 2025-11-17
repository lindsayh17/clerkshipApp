//  APGOView.swift
//  clerkshipApp

import SwiftUI

struct APGOView: View {
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
                        Text("APGO Topics & Requirement")
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
                                Text("Obstetric Topics")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            }
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("Clinic Topics")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            }
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("Gyn Topics")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            }
                            Text("APGO's Medical Student Education Objectives cover a total of 58 OBGyn topics.\n\nYou are encouraged to use the videos and cases to prep your knowledge base for encounters you have coming up, to follow-up experiences you've had and to study for the shelf exam.\n\nuWiseQuestions\nYou are required to complete 3 sets of 10 uWise quizzes, based on each service, for a total of 30 topics with a score of 70+. You will submit your APGO transcript, via the Clerkship App, at the end of each 2 weeks, with the final transcript being submitted to VIC Portal by the end of the rotation.\nNote: quizzes only appear on your APGO transcript when you score 70+ and you are able to retake the quizzes as many times as necessary.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .background(Color.white.opacity(0.1).cornerRadius(12))
                            // Buttons Section
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("Required uWise Topics - Checklist")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                            }
                            Text("Cases\nWhen going through the cases think less about the diagnosis (endometriosis) and more about what the patients cheif complant (dyspareunia) might be or how the patient would present. In general, it is best to link your learning with experiences you are seeing in the clincal enviroment. So for example, if you saw a patient in the clinic that has dyspareunia then that day I would recommend watching video #38 and # 39 on endometriosis and pelvic pain and working through case #38 and #39. Think about how pelvic pain from ovarian torsion might differ from nephrolithiasis, etc. Think about how the history, physical exam, teests distinguish one diagnosis for pelvic pain from the other. ")
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
        APGOView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}


