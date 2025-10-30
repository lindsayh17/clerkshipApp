//  MainButtonView.swift
//  clerkshipApp

import SwiftUI

struct MainButtonView: View {
    let title: String
    let color: Color
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, minHeight: 20)
                .padding()
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .scaleEffect(0.97, anchor: .center)
    }
}
