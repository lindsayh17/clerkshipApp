//  User.swift
//  clerkshipApp

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
    
    init(firebaseID: String, firstName: String, lastName: String, email: String) {
        self.firebaseID = firebaseID;
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.access = .student
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
