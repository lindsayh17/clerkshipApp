//
//  UserStore.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/4/25.
//

import SwiftUI

class UserStore: ObservableObject{
    @Published var allUsers: [User] = []
    
    func addUser(_ user: User){
        allUsers.append(user)
    }
}
