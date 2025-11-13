//  NavTab.swift
//  clerkshipApp

import SwiftUI

// Nav options for different screens
enum NavOption {
    case home
    case resources
    case search
    case profile
    case users
    case eval
}

// Bottom navigation bar
struct NavTab: View {
    @Binding var currentTab: NavOption
    @EnvironmentObject var currUser: CurrentUser

    private let buttonColor = Color("ButtonColor")
    private let backgroundColor = Color("BackgroundColor")

    // Determine which buttons to show for each user type
    private func buttonsForUser() -> [(icon: String, selection: NavOption, text: String)] {
        switch currUser.user?.access {
        case .student:
            return [
                ("house", .home, "Home"),
                ("text.document", .resources, "Docs"),
                ("person.crop.circle.fill", .profile, "Profile"),
                ("", .eval, "Eval") 
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
                ("text.document", .resources, "Docs"),
                ("person.crop.circle.fill", .profile, "Profile"),
                ("", .eval, "Eval")
            ]
        }
    }

    var body: some View {
        let buttons = buttonsForUser()

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

                if index < buttons.count - 1 {
                    // Adjust spacing between buttons
                    Spacer().frame(width: buttons.count == 4 ? 32 : 40)
                }
            }
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 16)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: 80)
        .background(buttonColor)
        .cornerRadius(40)
        .padding(.top, 15)
        .padding(.bottom, 0)
    }
}

// Individual navigation button
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
            VStack(spacing: 4) {
                // Circle icon
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

// Preview
#Preview {
    NavTab(currentTab: .constant(.home))
        .environmentObject(CurrentUser())
}

