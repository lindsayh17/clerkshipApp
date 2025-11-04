//  LocationsView.swift

/*
 TODO: change display options for students vs. preceptors
 TODO: send each link to a dummy page
 */

import SwiftUI

struct LocationsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills the screen
                backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 5) {
                        // Title
                        Text("Locations")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.bottom, 100)
                        
                        // Buttons
                        VStack(spacing: 20) {
                            MainButtonView(title: "UVMMC", color: buttonColor)
                            MainButtonView(title: "CVMC", color: buttonColor)
                            MainButtonView(title: "CVPH", color: buttonColor)
                            MainButtonView(title: "Porter Medical Center", color: buttonColor)
                            MainButtonView(title: "RRMC", color: buttonColor)
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 50) // Extra space at the end
                    }
                }
            }
        }
    }
}

// Preview
#Preview {
    LocationsView()
}



