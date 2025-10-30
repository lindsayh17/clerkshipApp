//
//  BigButtonView.swift
//  clerkshipApp
//

import SwiftUI

struct BigButtonView: View {
    var text = ""
    var action: () -> Void
    
    var width: CGFloat = 300
    var height: CGFloat = 60
    
    var foregroundColor = Color.white
    var backgroundColor = Color.accentColor
    
    // binding for disabled var??
    var disabled = false

    var body: some View {
        HStack {
            Button(action:self.action) {
                Text(self.text)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(BigButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          isDisabled: disabled))
                .disabled(self.disabled)
        }
        .frame(width: width, height: height)
    }
}

// I got help from stack overflow w/ this
// https://stackoverflow.com/questions/58928774/button-border-with-corner-radius-in-swift-ui
struct BigButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.white, lineWidth: 3)
                    .padding(3)
        )
            .padding([.top, .bottom], 10)
            .font(.title)
            .fontWeight(.semibold)
    }
}

