//
//  BigButtonView.swift
//  clerkshipApp
//

import SwiftUI

struct BigButtonView: View {
    var buttonText: String = ""
    var action: () -> Void
    var width: CGFloat = 300
    var height: CGFloat = 60
    var foregroundColor = Color.white
    var backgroundColor = Color.accentColor

    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .border(.white, width: 5)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .overlay(RoundedRectangle(cornerRadius: 5)
                          .stroke(backgroundColor, lineWidth: 2))
                        .cornerRadius(5)
        }
        .padding()
    }
}
