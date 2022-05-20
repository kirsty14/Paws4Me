//
//  SignUpViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/20.
//

import Foundation

// MARK: - SignInViewModel Delegate
protocol SignUpViewModelDelegate: AnyObject {
    func successRouting()
    func addUserData()
    func showError(errorMessage: String)
}

class SignUpViewModel {

    // MARK: - Vars/Lets
    private weak var delegate: SignUpViewModelDelegate?
    private var signUpRepository: SignUpRepository?
    private var userEmail: String = ""
    private var userPassword: String = ""

    var email: String {
        return userEmail
    }

    var password: String {
        return userPassword
    }

    init(delegate: SignUpViewModelDelegate, signUpRepository: SignUpRepository) {
        self.delegate = delegate
        self.signUpRepository = signUpRepository
    }

    // MARK: - Functions

    func isUserDetailsNotEmpty(name: String, surname: String, phone: String, address: String) -> Bool {
        var isUserDetailsNotEmpty = false
        if name.isEmpty || surname.isEmpty || phone.isEmpty || address.isEmpty {
            delegate?.showError(errorMessage: "Please fill in all your details")
        } else {
            isUserDetailsNotEmpty = true
        }
        return isUserDetailsNotEmpty
    }

    func isUserCredentialsEmpty() -> Bool {
        var isUserPasswordEmailEmpty = false
        if email.isEmpty || password.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your email and password")
        } else {
            isUserPasswordEmailEmpty = true
        }
        return isUserPasswordEmailEmpty
    }

    func addUserToFirebase(name: String, surname: String, cellphone: String, address: String) {
        signUpRepository?.addUserToFirebase(name: name,
                                            surname: surname,
                                            cellphone: cellphone,
                                            address: address) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successRouting()
            case .failure:
                self?.delegate?.showError(errorMessage: "Unable to save your details")
            }
    }
    }

    func signUpUser(email: String, password: String) {
        userEmail = email
        userPassword = password

        let isUserCredentialsEmpty = isUserCredentialsEmpty()

        if !isUserCredentialsEmpty {
            return
        } else {
            signUpRepository?.signUpUser(email: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.addUserData()
                case .failure:
                    self?.delegate?.showError(errorMessage: "Unable to Sign you Up")
                }
            }
        }
    }
}
