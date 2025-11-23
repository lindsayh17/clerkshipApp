//  OrientationView.swift
//  clerkshipApp

import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    
    @State private var goToSurgical: Bool = false
    @State private var goToTrauma: Bool = false
    @State private var goToFamilyPlanning: Bool = false
    @State private var goToSchedule = false
    @State private var navigateHome: Bool = false
    @State private var currentView: Destination = .home
    @EnvironmentObject var currUser: CurrentUser
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack() {
                ScrollView {
                    VStack() {
                        switch currentView {
                        case .home:
                            // Title
                            Text("Orientation")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top, 25)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            // Description
                            Text("OBGYN orientation will be on Monday, May 12th at UVM for all VT Campus students before traveling to their respective sites.")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.85))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                            
                            // Buttons
                            VStack(spacing: 15) {
                                // Hidden navigation links
                                NavigationLink("", destination: ScheduleView(), isActive: $goToSchedule).hidden()
                                NavigationLink("", destination: FamilyPlanningSessionView(), isActive: $goToFamilyPlanning).hidden()
                                NavigationLink("", destination: TraumaView(), isActive: $goToTrauma).hidden()
                                NavigationLink("", destination: SurgicalInstrumentsView(), isActive: $goToSurgical).hidden()
                                
                                MainButtonView(title: "Schedule", color: buttonColor) {
                                    goToSchedule = true
                                }
                                MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                                MainButtonView(title: "Family Planning Session", color: buttonColor) {
                                    goToFamilyPlanning = true
                                }
                                MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor) {
                                    goToTrauma = true
                                }
                                MainButtonView(title: "EPIC Orientation", color: buttonColor)
                                MainButtonView(title: "Surgical Instruments", color: buttonColor) {
                                    goToSurgical = true
                                }
                            }
                            .padding(.horizontal, 20)
                            .navigationBarBackButtonHidden(false)
                        case .resources:
                            ResourcesView()
                        case .search:
                            SearchView()
                        case .profile:
                            ProfileView()
                        case .users:
                            SearchView()
                        case .eval:
                            SearchView()
                        // TODO: fix these
                        case .root:
                            EmptyView()
                        case .login:
                            EmptyView()
                        case .register:
                            EmptyView()
                        case .quickFacts:
                            EmptyView()
                        case .orientation:
                            EmptyView()
                        case .requirements:
                            EmptyView()
                        case .evalChoice:
                            EmptyView()
                        }
                    }
                    .padding(.top, 10)
                }
                
                // Bottom navigation
                NavTab(currentTab: $currentView)
            }
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationDestination(isPresented: $navigateHome) {
            HomeView()
                .transition(.move(edge: .leading))
        }
        .navigationDestination(isPresented: $goToSchedule) {
            ScheduleView()
                .transition(.move(edge: .leading))
        }
        .navigationDestination(isPresented: $goToFamilyPlanning) {
            FamilyPlanningSessionView()
                .transition(.move(edge: .trailing))
        }
        .navigationDestination(isPresented: $goToTrauma) {
            TraumaView()
                .transition(.move(edge: .trailing))
        }
        .navigationDestination(isPresented: $goToSurgical) {
            SurgicalInstrumentsView()
                .transition(.move(edge: .trailing))
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        OrientationView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
