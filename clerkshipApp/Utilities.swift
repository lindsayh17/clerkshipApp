//
//  Utilities.swift
//  clerkshipApp
//
//  Created by Lindsay on 10/27/25.
//

import Foundation

//Custom Error Code
enum DBError: Error {
  case registrationFailed(errorMessage: String)
  case loginFailed(errorMessage: String)
  case fetchFailed(errorMessage: String)
}
