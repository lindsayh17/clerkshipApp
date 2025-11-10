//  Utilities.swift
//  clerkshipApp

import Foundation

//Custom Error Code
enum DBError: Error {
  case registrationFailed(errorMessage: String)
  case loginFailed(errorMessage: String)
  case fetchFailed(errorMessage: String)
}
