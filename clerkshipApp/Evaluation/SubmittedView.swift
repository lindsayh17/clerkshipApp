//  SubmittedView.swift
//  clerkshipApp

// TODO: make submitted view nicer, and have back button go to the home page, not back to eval

import SwiftUI

struct SubmittedView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 40) {
                Text("Submitted!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button("Return Home") {
                    dismiss()
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                Spacer()
            }
               
        }
        .padding()
    }

}

// Preview
#Preview {
    NavigationStack {
        SubmittedView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(CurrentUser())
    .environmentObject(AuthService())
}

