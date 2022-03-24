//
//  ViewModels.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

protocol Validation {
    func isValidCredentials(username: String, password: String) -> Bool
}

class SignInViewModel: Validation {

    // MARK: - Functions
    func isValidCredentials(username: String, password: String) -> Bool {
        if username == "Admin" && password == "TestPass123" {
            return true
        } else {
            return false
        }
    }
}
