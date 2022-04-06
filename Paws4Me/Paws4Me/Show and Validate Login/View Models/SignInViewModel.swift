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
    func showError(errorMessage: String)
}

class SignInViewModel {

    // MARK: - Vars/Lets
    private weak var delegate: SignInViewModelDelegate?

    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Functions
    func loginUser(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your username and password")
        }
            isValidCredentials(username: username, password: password) ? delegate?.successRouting() :
            delegate?.showError(errorMessage: "Incorrect Username or Password")
    }

     func isValidCredentials(username: String, password: String) -> Bool {
        return username == "Admin" && password == "TestPass123"
    }
}
