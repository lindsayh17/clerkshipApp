//
//  NavTab.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/2/25.
//
import SwiftUI

struct NavTab: View {
    @State private var currentTab = 0
      
    var body: some View {
        ZStack {
            VStack {
                // if we need more nav buttons, add them here
                Group {
                    switch currentTab {
                    case 1:
                        HomeView()
                    case 2:
                        ResourcesView()
                    default:
                        StudentProfile()
                    }
                }
            }
            ZStack {
                Color.gray
                    .opacity(0.4)
                    .cornerRadius(35)
                    .frame(height: 95)
                // Side spacing
                    .padding(.horizontal, 25)
                
                HStack {
                    NavBarButton(icon: "house", index: 1, text: "Home", currentTab: $currentTab).padding()
                    NavBarButton(icon: "text.document", index: 2, text: "Documents", currentTab: $currentTab).padding()
                    NavBarButton(icon: "person.crop.circle.fill", index: 3, text: "Profile", currentTab: $currentTab).padding()
                }
            }
        }
    }
}

// individual buttons
struct NavBarButton: View {
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    let icon: String
    let index: Int
    let text: String
    @Binding var currentTab: Int
    
    var body: some View {
        VStack {
            Button {
                currentTab = index
            } label: {
                ZStack {
                    Circle()
                        .fill(buttonColor) // Olive green
                        .frame(width: 50, height: 50)
                    Image(systemName: icon)
                        .padding()
                        .foregroundColor(backgroundColor)
                }
            }
            Text(text)
        }
    }
}

#Preview {
    NavTab()
}
