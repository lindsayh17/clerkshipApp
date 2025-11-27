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
            // Only students, no search filter
            return namesByLetter.mapValues { $0.filter { $0.access == .student } }
        } else {
            // Search text applied, still only students
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

    // Build namesByLetter
    func namesList() {
        namesByLetter = [:] // Reset
        for u in userStore.allUsers {
            guard u.access == .student else { continue } // Only students
            let firstChar = String(u.firstName.prefix(1)).uppercased()
            namesByLetter[firstChar, default: []].append(u)
        }
    }

    // Scroll to letter
    private func scrollTo(_ letter: Character) {
        print("Scroll to \(letter)")
    }

    // Body
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 0) {
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
                .padding(.top, 60)

                // Scrollable list with alphabet index
                ScrollViewReader { proxy in
                    ZStack(alignment: .trailing) {
                        NamesView(
                            filteredNames: filteredNames,
                            selectedUser: $selectedUser,
                            showEvalForm: $hasChosenStudent
                        )
                        .environmentObject(router)
                        .environment(\.defaultMinListRowHeight, 28)
                        .listSectionSpacing(.compact)
                        .scrollContentBackground(.hidden)
                        .background(backgroundColor)
                        .listStyle(.insetGrouped)
                        .foregroundColor(.white)

                        // Alphabet index
                        VStack(spacing: 6) {
                            ForEach(alphabet, id: \.self) { letter in
                                Button(action: { scrollTo(letter) }) {
                                    Text(String(letter))
                                        .font(.caption2)
                                        .fontWeight(.medium)
                                        .foregroundColor(buttonColor)
                                        .padding(.horizontal, 2)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.trailing, 6)
                    }
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
        // Build the names list whenever users load
        .task { namesList() }
        .onChange(of: userStore.allUsers) { _ in namesList() }
        .navigationBarBackButtonHidden(true)
    }
}

// NamesView
struct NamesView: View {
    var filteredNames: [String: [User]]
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")

    @Binding var selectedUser: User?
    @Binding var showEvalForm: Bool

    @EnvironmentObject var router: Router

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
                            .background(backgroundColor.opacity(0.8))
                        }
                        .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 1, trailing: 10))
                        .listRowBackground(backgroundColor.opacity(0.8))
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

