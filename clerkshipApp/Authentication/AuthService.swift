//
//  AuthenticationService.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

class AuthService: ObservableObject {
  var userSession: FirebaseAuth.User!
  var firebaseAuth: Auth!
  @Published var currentUser: String!
  @Published var isLoggedIn = false
  
  init() {
    self.currentUser = nil
    self.firebaseAuth = Auth.auth()
    if let user = self.firebaseAuth.currentUser {
      self.currentUser = user.email
    }
  }
  
  func reset() {
    self.isLoggedIn = false
    self.currentUser = nil
  }
  
  func createAccount(email: String, password: String) async throws {
    do {
      print("trying create with |\(email)|\(password)|")
      let authResult = try await firebaseAuth.createUser(withEmail: email, password: password)
      self.userSession = authResult.user
      if let session = userSession {
        print("createUser success: \(session)")
        DispatchQueue.main.async {
          self.currentUser = session.email
          self.isLoggedIn = true
        }
      }
    } catch {
      print("Error registering user or saving user data: \(error.localizedDescription)")
      throw DBError.registrationFailed(errorMessage: error.localizedDescription)
    }
  }
  
  func signIn(email: String, password: String) async throws {
    do {
      print("trying signin with |\(email)|\(password)|")
      let loginResult = try await firebaseAuth.signIn(withEmail: email, password: password)
      self.userSession = loginResult.user
      if let us = userSession {
        print("signIn successful: \(us)")
        DispatchQueue.main.async {
          self.currentUser = us.email
          self.isLoggedIn = true
        }
      }
    } catch {
      print("login failed for email \(email)")
      throw DBError.loginFailed(errorMessage: error.localizedDescription)
    }
  }
  
  func signOut() async throws {
    do {
      try firebaseAuth.signOut()
      self.userSession = nil
      DispatchQueue.main.async {
        self.currentUser = nil
        self.isLoggedIn = false
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}

