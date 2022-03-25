//
//  ViewModels.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

// MARK: - SignInViewModel Delegate
protocol SignInViewModelDelegate: AnyObject {
    func successRouting()
    func show(errorMessage: String)
}

class SignInViewModel {

    // MARK: - Functions
    func isValidCredentials(username: String, password: String) -> Bool {
        return username == "Admin" && password == "TestPass123"
    }
}
