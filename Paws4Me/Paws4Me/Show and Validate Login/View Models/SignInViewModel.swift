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

    // MARK: - Vars/Lets
    private weak var delegate: SignInViewModelDelegate?

    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }

    // MARK: - Functions
    func loginUser(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            delegate?.show(errorMessage: "Please fill in your username and password")
        }
            isValidCredentials(username: username, password: password) ? delegate?.successRouting() :
            delegate?.show(errorMessage: "Incorrect Username or Password")
    }

    private func isValidCredentials(username: String, password: String) -> Bool {
        return username == "Admin" && password == "TestPass123"
    }
}
