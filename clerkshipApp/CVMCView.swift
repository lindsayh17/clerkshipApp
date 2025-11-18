//  CVMCView.swift
//  clerkshipApp

import SwiftUI

struct CVMCView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    // @Binding var destination: HomeDestination

    
    @State private var navigateLocations: Bool = false
    
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
                        Text("Central\n Vermont Medical Center")
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
                            Text("130 Fisher Road MOB-A, Suite 1-1\n\nWomen's Health Clinic: MOB-A, Suite 104\n\nParking: Parking lot C (physician lot, does not require badge access)")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(16)
                                .background(Color.white.opacity(0.1).cornerRadius(12))
                            // Buttons Section
                            Button(action: {
                            // do something for Pregnancy Counseling
                            }) {
                                Text("CVMC Welcome Letter")
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

                NavTab(currentTab: $currentView)
            }
            BackButtonToLocations(navigateLocations: $navigateLocations)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationDestination(isPresented: $navigateLocations) {
            LocationsView()
                .transition(.move(edge: . leading))
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        CVMCView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}
