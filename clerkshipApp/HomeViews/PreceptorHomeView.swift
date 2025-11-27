//  PreceptorHomeView.swift
//  clerkshipApp

import SwiftUI

struct PreceptorHomeView: View {
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    
    @State private var currentView = Destination.home

    // Allows Eval tab to trigger navigation instead of swapping the whole screen
    @State private var showEvalFromTab = false
    
    @EnvironmentObject var currUser: CurrentUser
    
    // Router object to centralize navigation
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        // Preceptor view inside HomeView
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome, \(currUser.user?.firstName ?? "Preceptor")")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
