//  NavTab.swift
//  clerkshipApp

import SwiftUI

enum NavOption {
    case home
    case resources
    case search
    case profile
}

// The whole nav bar
struct NavTab: View {
    @Binding var currentTab: NavOption
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .cornerRadius(35)
                .frame(height: 80)
                // Side spacing
                .padding(.horizontal, 25)
                .padding(.top, 15)
            
            HStack {
                NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab).padding()
                NavBarButton(icon: "text.document", selection: .resources, text: "Docs", currentTab: $currentTab).padding()
                NavBarButton(icon: "magnifyingglass", selection: .search, text: "Search", currentTab: $currentTab).padding()
                NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab).padding()
            }
            .frame(height: 80)
            // Side spacing
            .padding(.horizontal, 25)
            .padding(.top, 15)
//
        }
    }
}

// individual buttons
struct NavBarButton: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    let icon: String
    let selection: NavOption
    let text: String
    @Binding var currentTab: NavOption
    
    var body: some View {
        VStack {
            Button {
                currentTab = selection
            } label: {
                ZStack {
                    Circle()
                        .fill(buttonColor)
                        .frame(width: 50, height: 50)
                    Image(systemName: icon)
                        .padding()
                        .foregroundColor(backgroundColor)
                }
            }
        }
    }
}
