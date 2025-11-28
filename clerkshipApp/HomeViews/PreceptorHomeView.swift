//  PreceptorHomeView.swift
//  clerkshipApp

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
                // Welcome message
                VStack(alignment: .center, spacing: 8) {
                    Text("Welcome, \(currUser.user?.firstName ?? "Preceptor")")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                .padding(.bottom, 20)
                
                // Centered graphic
                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .foregroundColor(.white.opacity(0.3))
            
                VStack(spacing: 20) {
                    HomeNavCard(title: "Location Information", icon: "location", color: .blue) {
                        router.push(.locations)
                    }
                    
                    HomeNavCard(title: "Evaluate Student", icon: "doc.text.fill", color: .orange) {
                        router.push(.search)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 50)
                
            }.padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden()
    }
}

