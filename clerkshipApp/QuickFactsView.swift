//  QuickFactsView.swift
//  clerkshipApp

import SwiftUI

struct QuickFactsView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills the screen
                backgroundColor.ignoresSafeArea()

            }
        }
    }
}

// Preview
#Preview {
    QuickFactsView()
}
