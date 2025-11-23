//  SubmittedView.swift
//  clerkshipApp

// TODO: make submitted view nicer, and have back button go to the home page, not back to eval

import SwiftUI

struct SubmittedView: View {
    @EnvironmentObject var router: Router
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @Environment(\.dismiss) private var dismiss
    @State private var goHome = false

    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 40) {
                Text("Submitted!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                NavigationLink(destination: HomeView(), isActive: $goHome) {
                    EmptyView()
                }

                Button("Return Home") {
                    goHome = true
                    router.popToRoot()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(buttonColor)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                
            }
               
        }
        .navigationBarBackButtonHidden(true)
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

