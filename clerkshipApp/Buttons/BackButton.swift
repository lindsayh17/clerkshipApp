//
//  BackButton.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/4/25.
//
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    private let color = Color("ButtonColor")
    
    let title = "\u{2190} Back"
    
    var body: some View {
        VStack {
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            // this pops the view from the nav stack
                            // i.e. goes back to previous page
                            dismiss()
                        } label: {
                            Text(title)
                                .fontWeight(.semibold)
                                .frame(width: 75, height: 30)
                                .background(color.opacity(0.4))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        .scaleEffect(0.97, anchor: .center)
                    }
                }
    }
}
