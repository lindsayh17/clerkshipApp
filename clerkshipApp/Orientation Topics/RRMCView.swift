//  RRMCView.swift
//  clerkshipAp

import SwiftUI

struct RRMCView: View {
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
                        Text("Rutland\nRegional Medical Center")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        }
                        // Description area
                        VStack(alignment: .center, spacing: 10) {
                            Text("160 Allen Street, Rutland, VT, 05701\n\nVisitor parking is located in front of the main entrance\n\nRutland Women's Health Care\n147 Allen Street, Rutland, VT, 05701\n\nParking is also available at the clinic")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .background(Color.white.opacity(0.1).cornerRadius(12))
                            // Buttons Section
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("Housing")
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
                                Text("Onboarding")
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
                                Text("Schedule Info")
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
                                Text("Obstetrics - L&D")
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
                                Text("Gyn - Surgery")
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
                                Text("Clinic")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(buttonColor)
                                    .cornerRadius(12)
                                    .shadow(radius: 4)
                                
                        }
                        .padding(.bottom, 20)
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
        RRMCView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

