//
//  SignUpViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/20.
//

import Foundation
import Firebase

// MARK: - SignInViewModel Delegate
protocol SignUpViewModelDelegate: AnyObject {
    func successRouting()
    func showError(errorMessage: String)
}

class SignUpViewModel {

    // MARK: - Vars/Lets
    private weak var delegate: SignUpViewModelDelegate?
    private var signUpRepository: SignUpRepository?

    init(delegate: SignUpViewModelDelegate, signUpRepository: SignUpRepository ) {
        self.delegate = delegate
        self.signUpRepository = signUpRepository
    }

    // MARK: - Functions
    func signUpUser(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your email and password")
        }

        signUpRepository?.signUpUser(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successRouting()
            case .failure:
                self?.delegate?.showError(errorMessage: "Unable to Sign you Up")
            }
        }
    }
}
