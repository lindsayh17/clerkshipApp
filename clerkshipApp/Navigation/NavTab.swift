//  NavTab.swift
//  clerkshipApp

import SwiftUI

enum AccessLevel: String, Codable {
    case student
    case preceptor
    case admin
}

// Bottom navigation bar
struct NavTab: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var currUser: CurrentUser
    @State var currView: Destination
    
    private let buttonColor = Color("ButtonColor")
    private let backgroundColor = Color("BackgroundColor")
    
    // Determine which buttons to show for each user type
    private func buttonsForUser() -> [(icon: String, selection: Destination, text: String)] {
        if let u = currUser.user{
            switch u.access {
            case .student:
                return [
                    ("house", .home, "Home"),
                    ("text.document", .resources, "Docs"),
                    ("person.crop.circle.fill", .profile, "Profile"),
                    // TODO: these should not be unbound w/ the !
                    ("pencil", .evalChoice(userToEval: u), "Eval")
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
                // defaults to a student
            default:
                return [
                    ("house", .home, "Home"),
                    ("text.document", .resources, "Docs"),
                    ("person.crop.circle.fill", .profile, "Profile"),
                    // TODO: these should not be unbound w/ the !
                    ("pencil", .evalChoice(userToEval: u), "Eval")
                ]
            }
        }else{
            return [
                ("house", .home, "Home"),
                ("text.document", .resources, "Docs"),
                ("person.crop.circle.fill", .profile, "Profile"),
                // TODO: these should not be unbound w/ the !
                ("pencil", .evalChoice(userToEval: User(firstName: "Student", lastName: "Name", email: "Student.Name@uvm.edu")), "Eval")
            ]
        }
    }

    var body: some View {
        let buttons = buttonsForUser()
        VStack {
            HStack {
                ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                    NavBarButton(
                        currView: $currView,
                        icon: button.icon,
                        selection: button.selection,
                        text: button.text,
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
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: 80, alignment: .bottom)
            .background(buttonColor)
            .cornerRadius(40)
            .padding(.top, 15)
            .padding(.bottom, 0)
        }
    }
}

// Individual navigation button
struct NavBarButton: View {
    @EnvironmentObject var router: Router
    @Binding var currView: Destination
    
    let icon: String
    let selection: Destination
    let text: String
    let buttonColor: Color
    let backgroundColor: Color

    var body: some View {
        let isSelected = currView == selection

        Button {
            router.switchRoot(selection)
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
    NavTab(currView: .home)
}

