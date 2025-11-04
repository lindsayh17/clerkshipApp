//
//  BackButton.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/4/25.
//
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    let title = "\u{2190} Back"
    let color: Color
    var action: () -> Void = {}
    
    var body: some View {
        VStack {
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: action) {
                            Text(title)
                                .fontWeight(.semibold)
                                .frame(width: 75, height: 30)
                                .background(color.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        .scaleEffect(0.97, anchor: .center)
                    }
                }
    }
}
