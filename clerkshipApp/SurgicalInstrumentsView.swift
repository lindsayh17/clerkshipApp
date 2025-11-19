//  SurgicalInstrumentsView.swift
//  clerkshipApp


import SwiftUI

struct Instruments: Identifiable {
    let id = UUID()
    let title: String
    let descriptions: [String]
}

struct SurgicalInstrumentsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")

    // State for nav tab
    @State private var currentView: NavOption = .resources
    @EnvironmentObject var currUser: CurrentUser
    @Environment(\.dismiss) var dismiss
    
    // Quick Facts data
    private let data: [Instruments] = [
        Instruments(title: " ",
                      descriptions:  [
                        "Used surgical instruments ca be obtained at the CSR - McClure Lobby"
                    ]),
        Instruments(title: "\nDirections: ",
                      descriptions:  [
                        "1. Go to the McClure staircase\n2. Go to the 1st floor (as if going to the Harvest Cafe)\n3. Walk through the first door but NOT the second (to go to Harvest Cafe you would walk through the second door)\n4. Turn left\n 5. See CSR sign and follow it (turn right, go down the hallway)\n6. The CSR should be down the hall on your left"
                    ]),
        Instruments(title: " ",
                      descriptions:  [
                        "Explain to staff that you are a medical student beginning a surgical rotation and would like a set of retired surgical tools and sutures."
                    ])
    ]
    
    var body: some View {
        ZStack (alignment: .topLeading){
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 15) {
                        // Title - centered
                        Text("Surgical\nInstruments")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        // Quick Facts list - left aligned
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(data) { item in
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.title)
                                        .font(.title)
                                        .foregroundColor(.white)
                                    
                                    ForEach(item.descriptions, id: \.self) { desc in
                                        Text(LocalizedStringKey(desc))
                                             .font(.subheadline)
                                             .foregroundColor(.white.opacity(0.8))
                                             .padding(.leading, 8)
                                     }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    }
                }
                // Bottom Navigation
                NavTab(currentTab: $currentView)
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
        SurgicalInstrumentsView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
}
