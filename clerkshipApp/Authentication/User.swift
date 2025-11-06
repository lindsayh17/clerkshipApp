//
//  User.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/2/25.
//

import SwiftUI

struct User: Identifiable, Codable {
    
    enum AccessLevel: String, Codable {
        case student
        case preceptor
        case admin
    }
    
    var id = UUID()
    var firebaseID = ""
    var firstName: String
    var lastName: String
    var email: String
    var access: AccessLevel
    
    init(firebaseID: String, firstName: String, lastName: String, email: String, access: AccessLevel) {
        self.firebaseID = firebaseID;
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = access
    }
    
    init(firstName: String, lastName: String, email: String, access: AccessLevel) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = access
    }
    
    init(firstName: String, lastName: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = .student
    }
    
    func getPrivilege() -> AccessLevel{
        return access
    }
}
