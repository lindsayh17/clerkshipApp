//  NavTab.swift
//  clerkshipApp

import SwiftUI

// Nav options for different screens
enum NavOption {
    case home
    //case quiz // student only
    case resources
    case search // preceptor and admin
    case profile
    case users
    // Eval for form when pulling it up from student side
    case eval
}

// The whole nav bar
struct NavTab: View {
    @Binding var currentTab: NavOption
    @EnvironmentObject var currUser: CurrentUser
    private let buttonColor = Color("ButtonColor")
    private let backgroundColor = Color("BackgroundColor")

    // Helper function to determine which buttons to show for each user
    private func buttonsForUser() -> [(icon: String, selection: NavOption, text: String)] {
        switch currUser.user?.access {
        case .student:
            return [
                ("house", .home, "Home"),
                ("text.document", .resources, "Docs"),
                ("person.crop.circle.fill", .profile, "Profile")
            ]
        case .preceptor:
            return [
                ("house", .home, "Home"),
                ("magnifyingglass", .search, "Search"),
                ("person.crop.circle.fill", .profile, "Profile")
            ]
        case .admin:
            return [
                ("house", .home, "Home"),
                ("magnifyingglass", .users, "Users"),
                ("person.crop.circle.fill", .profile, "Profile")
            ]
        default:
            return [
                ("house", .home, "Home"),
                ("magnifyingglass", .search, "Search"),
                ("person.crop.circle.fill", .profile, "Profile"),
                ("", .eval, "Eval") // default/student fallback
            ]
        }
    }

    var body: some View {
        VStack {
            // push nav bar to bottom
            Spacer()
            let buttons = buttonsForUser()
                // HStack for buttons
            HStack {
                ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                    NavBarButton(
                        icon: button.icon,
                        selection: button.selection,
                        text: button.text,
                        currentTab: $currentTab,
                        buttonColor: buttonColor,
                        backgroundColor: backgroundColor
                    )
                    // Add spacer **between** buttons except after the last one
                    if index < buttons.count - 1 {
                        // smaller spacing if 4 buttons
                        Spacer().frame(width: buttons.count == 4 ? 32 : 40)
                    }
                }
            }
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
          .frame(maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: 80)
          .background(buttonColor)
          // rounded edges
          .cornerRadius(35)
          .padding(.bottom, 0)
          .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Individual nav buttons
struct NavBarButton: View {
    let icon: String
    let selection: NavOption
    let text: String
    @Binding var currentTab: NavOption
    let buttonColor: Color
    let backgroundColor: Color
   

    var body: some View {
        let isSelected = currentTab == selection

        Button {
            currentTab = selection
        } label: {
            VStack (spacing: 4) {
                // Circle with icon overlay
                Circle()
                    .fill(isSelected ? backgroundColor : Color.white)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(isSelected ? Color.white : buttonColor)
                    )

                // Label text
                Text(text)
                    .font(.caption)
                    .foregroundColor(isSelected ? backgroundColor : .white)
            }
        }
    }
}

