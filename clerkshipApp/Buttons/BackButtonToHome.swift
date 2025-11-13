//  BackButtonToHome.swift
//  clerkshipApp

import SwiftUI

struct BackToHomeButton: View {
    @State private var goHome: Bool = false
    private let color = Color("ButtonColor")
    private let title = "\u{2190}" // ←

    var body: some View {
        ZStack {
            // NavigationLink triggers programmatic navigation
            NavigationLink(destination: HomeView(), isActive: $goHome) {
                EmptyView()
            }

            // Floating button
            Button(action: {
                goHome = true
            }) {
                Text(title)
                    .fontWeight(.semibold)
                    .frame(width: 85, height: 45)
                    .background(color)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.leading, 24)
            .padding(.top, 10)
            .zIndex(1)
        }
    }
}

