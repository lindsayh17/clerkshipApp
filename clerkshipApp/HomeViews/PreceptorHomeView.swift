// PreceptorHomeView.swift
// clerkshipApp

import SwiftUI

struct PreceptorHomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    @State private var currentView = Destination.home
    @State private var showEvalFromTab = false
    
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Welcome Message
                    VStack(alignment: .center, spacing: 8) {
                        Text("Welcome, \(currUser.user?.firstName ?? "Preceptor")")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top, 60)
                    .padding(.bottom, 100)
                    
                    // Instructions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("How to Fill Out a Student Evaluation")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("1. Click the **Search** button on the navigation bar.")
                            Text("2. Select the student you are filling the evaluation out for.")
                            Text("3. Select the type of evaluation you are completing.")
                            Text("4. Complete the form and press **Submit**.")
                        }
                        .font(.body)
                        .foregroundColor(.white.opacity(0.85))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
