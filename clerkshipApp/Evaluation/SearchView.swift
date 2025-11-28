// SearchView.swift
// clerkshipApp

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router

    @State private var searchText = ""
    @State private var selectedUser: User? = nil
    @State private var hasChosenStudent = false

    @Environment(\.dismiss) var dismiss

    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")

    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @State private var namesByLetter: [String: [User]] = [:]

    // Nav state
    @State private var currentView: Destination = .search

    // Filtered data for the list
    private var filteredNames: [String: [User]] {
        if searchText.isEmpty {
            return namesByLetter.mapValues { $0.filter { $0.access == .student } }
        } else {
            var filtered: [String: [User]] = [:]
            for (letter, users) in namesByLetter {
                let studentsOnly = users.filter {
                    $0.access == .student &&
                    "\($0.firstName) \($0.lastName)".localizedCaseInsensitiveContains(searchText)
                }
                if !studentsOnly.isEmpty { filtered[letter] = studentsOnly }
            }
            return filtered
        }
    }

    // Build namesByLetter: only students, sorted by last name then first name
    func namesList() {
        namesByLetter = [:]
        for u in userStore.allUsers {
            guard u.access == .student else { continue }
            let firstChar = String(u.lastName.prefix(1)).uppercased()
            namesByLetter[firstChar, default: []].append(u)
        }

        for key in namesByLetter.keys {
            namesByLetter[key]?.sort {
                if $0.lastName == $1.lastName {
                    return $0.firstName < $1.firstName
                }
                return $0.lastName < $1.lastName
            }
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 0) {
                Text("Student search:")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.7))
                    TextField("Search", text: $searchText)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(10)
                .background(buttonColor.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.top, 40)

                // Names list with alphabet index
                ZStack(alignment: .trailing) {
                    NamesView(
                        filteredNames: filteredNames,
                        selectedUser: $selectedUser,
                        showEvalForm: $hasChosenStudent,
                        backgroundColor: backgroundColor
                    )
                    .environmentObject(router)
                    .environment(\.defaultMinListRowHeight, 28)
                    .listSectionSpacing(.compact)
                    .scrollContentBackground(.hidden)
                    .background(backgroundColor)
                    .listStyle(.insetGrouped)
                    .foregroundColor(.white)

                    // Alphabet index (visual only)
                    VStack(spacing: 6) {
                        ForEach(alphabet, id: \.self) { letter in
                            Text(String(letter))
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(buttonColor)
                                .padding(.horizontal, 2)
                        }
                    }
                    .padding(.trailing, 6)
                }

                // Nav tab only if current user is NOT student
                if currUser.user?.access != .student {
                    NavTab(currView: currentView)
                }
            }

            // Back button only for students
            if currUser.user?.access == .student {
                BackButton()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
            }
        }
        .task { namesList() }
        .onChange(of: userStore.allUsers) { _ in namesList() }
        .navigationBarBackButtonHidden(true)
    }
}

// NamesView
struct NamesView: View {
    var filteredNames: [String: [User]]
    @Binding var selectedUser: User?
    @Binding var showEvalForm: Bool
    var backgroundColor: Color

    @EnvironmentObject var router: Router
    private let buttonColor = Color("ButtonColor")

    var body: some View {
        List {
            ForEach(filteredNames.keys.sorted(), id: \.self) { letter in
                Section(
                    header: Text(letter)
                        .font(.headline)
                        .foregroundColor(buttonColor)
                ) {
                    ForEach(filteredNames[letter, default: []].filter { $0.access == .student }, id: \.id) { student in
                        Button {
                            selectedUser = student
                            router.push(.evalChoice(userToEval: student))
                            showEvalForm = true
                        } label: {
                            HStack {
                                Text("\(student.firstName) \(student.lastName)")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(backgroundColor)
                        .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 1, trailing: 10))
                    }
                }
            }
        }
    }
}

// Preview
#Preview {
    NavigationStack {
        SearchView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(UserStore())
    .environmentObject(EvalStore())
    .environmentObject(CurrentUser())
    .environmentObject(Router(root: .home))
}

