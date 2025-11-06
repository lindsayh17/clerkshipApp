//  NavTab.swift
//  clerkshipApp

import SwiftUI

enum NavOption {
    case home
    //case quiz // student only
    case resources
    case search // preceptor and admin
    case profile
    case users
}


// The whole nav bar
struct NavTab: View {
    @Binding var currentTab: NavOption
    @EnvironmentObject var currUser: CurrentUser

    var body: some View {
        ZStack {
            Spacer()
            
            switch currUser.user?.access{
            case .student:
                HStack {
                    Spacer()
                    NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab)
                    Spacer()
                    // Quiz nav button //NavBarButton(icon: "house", selection: .quiz, text: "Home", currentTab: $currentTab).padding()
                    NavBarButton(icon: "text.document", selection: .resources, text: "Docs", currentTab: $currentTab)
                    Spacer()
                    NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab)
                    Spacer()
                }
            case .preceptor:
                HStack{
                    NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab).padding()
                    NavBarButton(icon: "magnifyingglass", selection: .search, text: "Search", currentTab: $currentTab).padding()
                    NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab).padding()
                }
            case .admin:
                HStack{
                    NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab).padding()
                    NavBarButton(icon: "magnifyingglass", selection: .users, text: "Users", currentTab: $currentTab).padding()
                    NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab).padding()
                }
            default:
                // use student view as default
                HStack {
                    NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab).padding()
                    NavBarButton(icon: "magnifyingglass", selection: .search, text: "Search", currentTab: $currentTab).padding()
                    NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab).padding()
//                    Spacer()
//                    NavBarButton(icon: "house", selection: .home, text: "Home", currentTab: $currentTab)
//                    Spacer()
//                    // Quiz nav button //NavBarButton(icon: "house", selection: .quiz, text: "Home", currentTab: $currentTab).padding()
//                    NavBarButton(icon: "text.document", selection: .resources, text: "Docs", currentTab: $currentTab)
//                    Spacer()
//                    NavBarButton(icon: "person.crop.circle.fill", selection: .profile, text: "Profile", currentTab: $currentTab)
//                    Spacer()
                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.gray.opacity(0.8))
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
        let isSelected = currentTab == selection
        Button {
            currentTab = selection
        } label: {
            VStack(){
                ZStack{
                    Circle()
                        .fill(buttonColor)
                        .frame(width: 50, height: 50)
                    Image(systemName: icon)
                        .padding()
                        .foregroundColor(backgroundColor)
                }
                Text(text)
                    .font(.caption)
                    .foregroundColor(isSelected ? buttonColor: .gray)
            }
            .padding(.top)
        }
    }
}
