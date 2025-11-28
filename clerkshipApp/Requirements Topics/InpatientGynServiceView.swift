//  InpatientGynServiceView.swift
//  clerkshipApp
//  Note: App content is hardcoded to help with the transfer of the app to the IT team at UVMMC


import SwiftUI

struct InpatientGynServiceView: View {
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
            
            VStack(spacing: 0) {
                // Scrollable content
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Page title
                        Text("Inpatient\n Gyn Service")
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
                            Text("You will be evaluated on your performance on the inpatient surgical service and in the operating room. This includes not just your surgical ability, but your understanding of the indications for surgery, the patients pertinent medical history, the relevant anatomy, and the basic steps of the surgical procedure. You will also be assessed on your care for post-op patients, medical admissions, ER admissions, and consults.")
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
                }

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
        InpatientGynServiceView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

