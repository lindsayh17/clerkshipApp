//  NavView.swift
//  clerkshipApp

import SwiftUI

struct NavView: View {
    private let buttonColor = Color(red: 0.68, green: 0.69, blue: 0.53)

    var body: some View {
        ZStack {
            // Background with transparency and rounded corners
            Color.white
                .opacity(0.6)
                .cornerRadius(35)
                .frame(height: 90)
                // Side spacing
                .padding(.horizontal, 25)
                // Bottom spacing
                .padding(.bottom, 10)
            // Feedback & Profile buttons
            HStack(spacing: 60) {
                // Feedback Button
                VStack {
                    Circle()
                        // Olive green
                        .fill(buttonColor)
                        .frame(width: 50, height: 50)
                    Text("Feedback")
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
                // Profile Button
                VStack {
                    Circle()
                        // Olive green
                        .fill(buttonColor)
                        .frame(width: 50, height: 50)
                    Text("Profile")
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
            }
        }
    }
}
