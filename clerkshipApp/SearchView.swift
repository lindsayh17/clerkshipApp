/*
 TODO: link each name to evaluation form
 TODO: figure out why it's printing weird/why extra users
    // I think its printing extra users cuz Ive tried the same name for myself multiple times lol
 */

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var userStore: UserStore
    @State private var searchText = ""
    
    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @State private var namesByLetter: [String: [String]] = [:]
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    // Filtered data based on search text
    private var filteredNames: [String: [String]] {
        if searchText.isEmpty {
            return namesByLetter
        } else {
            var filtered: [String: [String]] = [:]
            for (letter, names) in namesByLetter {
                let results = names.filter { $0.localizedCaseInsensitiveContains(searchText) }
                if !results.isEmpty {
                    filtered[letter] = results
                }
            }
            return filtered
        }
    }
    
    func namesList(){
        for u in userStore.allUsers{
            let firstChar = String(u.firstName.prefix(1)).uppercased()
            print(firstChar)
            let fullName = "\(u.firstName) \(u.lastName)"
            
            namesByLetter[firstChar, default: []].append(fullName)
        }
    }

    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack(spacing: 0) {
                    ScrollViewReader { proxy in
                        ZStack(alignment: .trailing) {
                            // Contact list
                            List {
                                ForEach(filteredNames.keys.sorted(), id: \.self) { letter in
                                    Section(
                                        header: Text(letter)
                                            .font(.headline)
                                            .foregroundColor(buttonColor)
                                    ) {
                                        ForEach(filteredNames[letter]!, id: \.self) { name in
                                            contactRow(name: name)
                                                .listRowInsets(EdgeInsets(top: 1, leading: 16, bottom: 1, trailing: 10))
                                                .listRowBackground(backgroundColor.opacity(0.8))
                                        }
                                    }
                                }
                            }
                            .environment(\.defaultMinListRowHeight, 28)
                            .listSectionSpacing(.compact)
                            .scrollContentBackground(.hidden)
                            .background(backgroundColor)
                            .listStyle(.insetGrouped)
                            .searchable(
                                text: $searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: "Search"
                            )
                            .tint(buttonColor)
                            
                            // Alphabet index
                            VStack(spacing: 6) {
                                ForEach(alphabet, id: \.self) { letter in
                                    Button(action: {
                                        scrollTo(letter)
                                    }) {
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
                }
            }.task { // like onAppear but for async?
                namesList()
            }
        }
    }
    
    private func scrollTo(_ letter: Character) {
        print("Scroll to \(letter)")
    }
}

// Components
private extension SearchView {
    func contactRow(name: String) -> some View {
        HStack {
            Text(name)
                .font(.body)
                .foregroundColor(.white)
        }
        .padding(.vertical, 0)
    }
}

// Preview
#Preview {
    SearchView().environmentObject(FirebaseService()).environmentObject(UserStore())
}


