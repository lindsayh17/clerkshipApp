//  SearchView1.swift
//  clerkshipApp

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var evalStore: EvalStore
    @EnvironmentObject var currUser: CurrentUser
    
    @State private var searchText = ""
    @State private var selectedUser: User? = nil

    @Environment(\.dismiss) var dismiss
    
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    private let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    @State private var namesByLetter: [String: [User]] = [:]
    
    // Nav state
    @State private var currentView: Destination = .search
    
    // Filtered data based on search text
    private var filteredNames: [String: [User]] {
        if searchText.isEmpty {
            return namesByLetter
        } else {
            var filtered: [String: [User]] = [:]
            for (letter, students) in namesByLetter {
                let results = students.filter {user in
                    let fullName = "\(user.firstName) \(user.lastName)"
                    return fullName.localizedCaseInsensitiveContains(searchText) }
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
            // only add new names (avoid duplication)
            if !namesByLetter[firstChar, default: []].contains(where: { $0.id == u.id }) {
                namesByLetter[firstChar, default: []].append(u)
            }
        }
        print("Names list: \(namesByLetter)")
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Fixed search bar at the top
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
                
                ScrollViewReader { proxy in
                    ZStack(alignment: .trailing) {
                        NamesView(
                            filteredNames: filteredNames,
                            selectedUser: $selectedUser
//                            showEvalForm: $navControl.showEvalForm
                        )
                        .environment(\.defaultMinListRowHeight, 28)
                        .listSectionSpacing(.compact)
                        .scrollContentBackground(.hidden)
                        .background(backgroundColor)
                        .listStyle(.insetGrouped)
                        .foregroundColor(.white)
                        
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
            // Don't need back button if user is preceptor; use nav bar
            // Back button stays in the ZStack
            if currUser.user?.access == .student {
                BackButton()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
            }
        }
        .task {
            namesList()
        }
//        .navigationDestination(isPresented: $navControl.showEvalForm){
//            if let selected = selectedUser{
//                FormChoiceView(currStudent: selected)
//            }
//        }
        .navigationBarBackButtonHidden(true)
    }
}

private func scrollTo(_ letter: Character) {
    print("Scroll to \(letter)")
}

// Components
private extension NamesView {
    func contactRow(user: User) -> some View {
        HStack {
            Button(action: {selectedUser = user}, label: {Text("\(user.firstName) \(user.lastName)").font(.body)
                .foregroundColor(.white)})
        }
        .padding(.vertical, 0)
    }
}

struct NamesView: View{
    var filteredNames: [String: [User]]
    // Colors
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    @Binding var selectedUser: User?
//    @Binding var showEvalForm: Bool
    
    @EnvironmentObject var router: Router
    
    var body: some View{
        List {
            ForEach(filteredNames.keys.sorted(), id: \.self) { letter in
                Section(
                    header: Text(letter)
                        .font(.headline)
                        .foregroundColor(buttonColor)
                ) {
                    ForEach(filteredNames[letter, default: []], id: \.id) { student in
                        Button {
                            selectedUser = student
                            
                            // TODO: check this !!!!
                            router.push(.evalChoice)
//                            showEvalForm = true
                            
                        } label: {
                            HStack{
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
}

