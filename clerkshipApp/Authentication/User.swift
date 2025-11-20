//  User.swift
//  clerkshipApp

import SwiftUI

struct User: Identifiable, Codable, Hashable {
    
    enum AccessLevel: String, Codable {
        case student
        case preceptor
        case admin
    }
    
    var id: String?
    var firstName: String
    var lastName: String
    var email: String
    var access: AccessLevel
    
    init(id: String? = nil, firstName: String, lastName: String, email: String, access: AccessLevel) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = access
    }
    
    init(id: String? = nil, firstName: String, lastName: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = .student
    }
    
    func getPrivilege() -> AccessLevel{
        return access
    }
}
