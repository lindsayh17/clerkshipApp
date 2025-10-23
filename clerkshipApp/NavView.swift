//
//  NavView.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/18/25.
//

import SwiftUI

// Color + rounded corners
struct NavView: View{
    var body: some View {
        ZStack{
            Color.white
            // Transparency
                .opacity(0.6)
                .cornerRadius(35)
                .frame(height: 90)
            // Side spacing
                .padding(.horizontal, 25)
            // Bottom spacing
                .padding(.bottom, 10)
            
            // Feedback & Profile buttons
            HStack(spacing: 60) {
                // Feedback button
                VStack {
                    Circle()
                    // Olive green
                        .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                        .frame(width: 50, height: 50)
                    Text("Feedback")
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
                
                // Profile button
                VStack {
                    Circle()
                    // Olive green
                        .fill(Color(red: 0.68, green: 0.69, blue: 0.53))
                        .frame(width: 50, height: 50)
                    Text("Profile")
                        .foregroundColor(.black)
                        .padding(.top, 4)
                }
            }
        }
    }
}
