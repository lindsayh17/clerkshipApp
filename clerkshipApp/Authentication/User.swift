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
    var firstName: String
    var lastName: String
    var email: String
    var privelege: AccessLevel
    
    init(firstName: String, lastName: String, email: String, privelege: AccessLevel) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.privelege = privelege
    }
    
    init(firstName: String, lastName: String, email: String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.privelege = .student
    }
}
