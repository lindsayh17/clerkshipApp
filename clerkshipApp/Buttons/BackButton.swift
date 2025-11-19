// BackButton.swift

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    private let color = Color("ButtonColor")
    let title = "\u{2190}"

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                dismiss()
            }
        }) {
            Text(title)
                .fontWeight(.semibold)
                .frame(width: 55, height: 55)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
        .padding(.leading, 15)
        .padding(.top,45)
        .zIndex(1)
    }
}

