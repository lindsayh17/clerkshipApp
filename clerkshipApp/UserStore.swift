//  UserStore.swift
//  clerkshipApp

import SwiftUI

class UserStore: ObservableObject{
    @Published var allUsers: [User] = []
    
    func addUser(_ user: User){
        allUsers.append(user)
    }
}
