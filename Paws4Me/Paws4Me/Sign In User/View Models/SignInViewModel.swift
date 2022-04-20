//
//  ViewModels.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation
import Firebase

// MARK: - SignInViewModel Delegate
protocol SignInViewModelDelegate: AnyObject {
    func successRouting()
    func showError(errorMessage: String)
}

class SignInViewModel {

    // MARK: - Vars/Lets
    private weak var delegate: SignInViewModelDelegate?
    private var signInRepository: SignInRepository?

    init(delegate: SignInViewModelDelegate, signInRepository: SignInRepository ) {
        self.delegate = delegate
        self.signInRepository = signInRepository
    }

    // MARK: - Functions
    func loginUser(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your email and password")
        }

        signInRepository?.signInUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successRouting()
            case .failure:
                self?.delegate?.showError(errorMessage: "Incorrect email or Password")
            }
        }
    }
}
