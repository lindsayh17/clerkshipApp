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
                        Button("Schedule") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                        
                        Button("Intrapartum FHR Interpretation") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                        
                        Button("Family Planning Session") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                        
                        Button("Trauma Informed Care and Labor Support") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                        
                        Button("EPIC Orientation") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                        
                        Button("Surgical Instruments") {}
                            .buttonStyle(MainButtonStyle(color: buttonColor))
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
        }
    }
}

// Custom button style for consistent appearance
struct MainButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .lineLimit(nil) // no line limit
            .frame(maxWidth: .infinity, minHeight: 20)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
    }
}

// Preview
#Preview {
    OrientationView()
}

