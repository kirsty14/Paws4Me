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
    private var signInRepository: SignInRepository?
    private var emailUser: String = ""
    private var passwordUser: String = ""
    private var userCurrentEmail = ""
    private var userCurrentPassword = ""

    init(delegate: SignInViewModelDelegate, signInRepository: SignInRepository ) {
        self.delegate = delegate
        self.signInRepository = signInRepository
    }

    // MARK: - Functions
    var email: String {
        return emailUser
    }

    var password: String {
        return passwordUser
    }

    func set(userEmail: String, userPassword: String) {
        emailUser = userEmail
        passwordUser = userPassword
    }

    func setUserCredentials(email: String, password: String) {
        if emailUser != "" && passwordUser != "" {
            userCurrentEmail = emailUser
            userCurrentPassword = passwordUser
        } else {
            userCurrentEmail = email
            userCurrentPassword = password
        }
    }

    func isCredentialsEmpty(email: String, password: String) -> Bool {
        var bNotEmpty = false

        if userCurrentEmail.isEmpty || userCurrentPassword.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your email and password")
        } else {
            bNotEmpty = true
        }
        return bNotEmpty
    }

    func isPasswordLongEnough(email: String, password: String) -> Bool {
        var bValidPasword = false

        if userCurrentPassword.count != 6 {
            delegate?.showError(errorMessage: "Please enter a password that is 6 characters long")
        } else {
            bValidPasword = true
        }
        return bValidPasword
    }

    func loginUser(email: String, password: String) {
        setUserCredentials(email: email, password: password)
        let bCredentialsValid = isCredentialsEmpty(email: email,
                                                   password: password)
        let bValidPassword = isPasswordLongEnough(email: email,
                                                  password: password)

        if !bCredentialsValid || !bValidPassword {
            return
        } else {
            signInRepository?.signInUser(email: userCurrentEmail,
                                         password: userCurrentPassword) { [weak self] result in
                switch result {
                case .success:
                    self?.delegate?.successRouting()
                case .failure:
                    self?.delegate?.showError(errorMessage: "Incorrect email or Password")
                }
            }
        }
    }
}
