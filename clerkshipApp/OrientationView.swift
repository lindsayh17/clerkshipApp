//  OrientationView.swift
//  clerkshipApp

import SwiftUI

struct OrientationView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills entire screen
                backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 5) {
                    // Title
                    Text("Orientation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    // Description
                    Text("OBGYN orientation will be on Monday, May 12th at UVM for all VT Campus students before traveling to their respective sites.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .padding(.bottom, 35)
                    
                    // Buttons
                    VStack(spacing: 20) {
                        MainButtonView(title: "Schedule", color: buttonColor)
                        MainButtonView(title: "Intrapartum FHR Interpretation", color: buttonColor)
                        MainButtonView(title: "Family Planning Session", color: buttonColor)
                        MainButtonView(title: "Trauma Informed Care and Labor Support", color: buttonColor)
                        MainButtonView(title: "EPIC Orientation", color: buttonColor)
                        MainButtonView(title: "Surgical Instruments", color: buttonColor)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
        }
    }
}


// Preview
#Preview {
    OrientationView()
}

