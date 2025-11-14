//  SearchViewBackButton.swift
//  clerkshipApp

import SwiftUI

struct SearchViewBackButton: View {
    @Binding var navigateSearch: Bool
    private let color = Color("ButtonColor")
    private let title = "\u{2190}"

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                navigateSearch = true
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
        .padding(.top, 45)
        .zIndex(1)
        .buttonStyle(.plain)
    }
}
