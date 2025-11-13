// BackButton.swift

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    private let color = Color("ButtonColor")
    let title = "\u{2190}"

    var body: some View {
        Button(action: {
            dismiss()
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

