//  BreastExamView.swift
//  clerkshipApp

import SwiftUI

struct BreastExamView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    // @Binding var destination: HomeDestination
    
    @State private var navigateResources: Bool = false
    
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
                        Text("Breast Exam")
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
                            Text("-Knocks on door\n-Verifies patient name (before beginning HPI)\n-Introduced self\n-Describes role\n-Establishes rapport\n-Conveys empathy\n-Demonstrates concern for patient's physical comfort (pulls out table if needed, etc.; verbal inquiry required in cases where patient is visibly uncomfortable)\n-Demonstrates concern for patients modesty\n-Professional dress and demeanor\n-Encounter is structured and time efficient\n-Inspect breasts w/ patient seated (view all side)\n-Inspect while patient holds hands against hips and press inward (view from all side)\n-Palpate supraclavicular nodes\n-Palpate infraclavicular nodes\n-Palpate axillae (Support arm and wrist with examiner hand)\n-Palpate axillae (Ask patient to relax arm being examined)\n-Palpate axillae (Cup fingers together and reach as high as possible into the apex of the axillae)\n-Palpate axillae (Press fingers toward the chest wall)\n-Student instructs patient to lie down and raise arm and rest hand on forehead for breast palpation (same side arm)\n-Breast Palpation : Bilateral (Uses middle 3 fingers of hand to palpate breast)\n-Starts on the top of breast\n-Starts on the axillary side\n-Uses 3 types of pressures, starts with light, then medium, then firm\n-Exam is not unduly painful, fingers never lose contact with skin, all palpation is on skin, never over gown\n-Palpates with overlapping dime sized circular motions\n-Uses vertical strip technique (from top to bottom and bottom to top)\n-Palpates over nipples\n-Palpates over tail of spence\n-Student palpates thoroughly, from mid axillary line to lateral edge of sternum and from clavicale to bra line")
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
            BackButtonToResources(navigateResources: $navigateResources)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationDestination(isPresented: $navigateResources) {
            ResourcesView()
                .transition(.move(edge: . leading))
        }
    .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        BreastExamView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

