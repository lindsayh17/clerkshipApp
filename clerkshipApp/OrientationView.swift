// OrientationView.swift
// clerkshipApp
//  Note: App content is hardcoded to help with the transfer of the app to the IT team at UVMMC


import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    // State to track which section is open
    @State private var openSection: String? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
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
                    
                    // Sections with Quick-Facts-style dropdowns
                    VStack(spacing: 20) {
                        section(title: "Orientation Basics") {
                            MainButtonView(title: "Schedule", color: buttonColor) {
                                router.push(.schedule)
                            }
                            MainButtonView(title: "Locations", color: buttonColor) {
                                router.push(.locations)
                            }
                        }
                        
                        section(title: "Clinical Skills / Procedures") {
                            MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                            MainButtonView(title: "Family Planning Session", color: buttonColor) {
                                router.push(.familyPlan)
                            }
                            MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor) {
                                router.push(.trauma)
                            }
                            MainButtonView(title: "Surgical Instruments", color: buttonColor) {
                                router.push(.surgicalInst)
                            }
                        }
                        
                        section(title: "Systems / Tools") {
                            MainButtonView(title: "EPIC Orientation", color: buttonColor)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .padding(.top, 10)
            }
            BackButton()
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Section Helper
    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: @escaping () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header Row
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
                    .rotationEffect(.degrees(openSection == title ? 90 : 0))
                    .animation(.easeInOut, value: openSection == title)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onTapGesture {
                withAnimation(.spring()) {
                    openSection = (openSection == title ? nil : title)
                }
            }
            
            // Expanded content
            if openSection == title {
                VStack(spacing: 15) {
                    content()
                }
                .padding(.top, 5)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
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

