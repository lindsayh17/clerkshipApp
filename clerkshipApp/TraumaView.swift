//  TraumaView.swift
//  clerkshipApp

import SwiftUI

struct TraumaView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    // @Binding var destination: HomeDestination
    
    @State private var navigateOrientation: Bool = false
    
    @State private var currentView = NavOption.home
    // @State var loginManager
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
                        Text("Trauma\nInformed Care and Labor Support")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                            .padding(.bottom, 20)

                        // Buttons Section
                        Button(action: {
                        // do something for Pregnancy Counseling
                        }) {
                            Text("Required Pre-Reading")
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
                            Text("Doula Perspective")
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
                            Text("What is Trauma Informed Care?")
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
                            Text("Trauma Informed Care: What & Why")
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
                            Text("Take Action. Save Lives")
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
                            Text("Childbirth Trauma")
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
                            Text("Painful Cervical Exams During Labor")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(buttonColor)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }

                NavTab(currentTab: $currentView)
            }
            BackButtonToOrientation(navigateOrientation: $navigateOrientation)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationDestination(isPresented: $navigateOrientation) {
            OrientationView()
                .transition(.move(edge: .leading))
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    TraumaView()
        .environmentObject(FirebaseService())
        .environmentObject(CurrentUser())
        .environmentObject(AuthService())
}



