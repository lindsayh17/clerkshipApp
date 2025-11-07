//
//  NavControl.swift
//  clerkshipApp
//
//  Created by Lindsay on 11/3/25.
//

import SwiftUI

class NavControl: ObservableObject{
    @Published var showRoot: Bool = false
    @Published var showCreateAccount: Bool = false
    @Published var showSignIn: Bool = false
    @Published var showEvalForm: Bool = false
}
