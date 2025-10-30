//  SectionView.swift
//  clerkshipApp

import SwiftUI

struct SectionView<Label: View>: View {
    let title: String
    let label: () -> Label
    
    private let buttonColor = Color("ButtonColor")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Button(action: {
                print("\(title) button tapped")
            }) {
                label()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 3)
            }
        }
    }
}

