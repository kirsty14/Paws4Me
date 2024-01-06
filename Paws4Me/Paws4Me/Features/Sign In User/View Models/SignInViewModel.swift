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

class SignInViewModel: ValidationManager {

    // MARK: - Vars/Lets
    private weak var delegate: SignInViewModelDelegate?
    private var signInRepository: SignInRepository?
    private var emailUser: String = ""
    private var passwordUser: String = ""
    private var userCurrentEmail = ""
    private var userCurrentPassword = ""

    init(delegate: SignInViewModelDelegate,
         signInRepository: SignInRepository ) {
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

    func set(userEmail: String,
             userPassword: String) {
        emailUser = userEmail
        passwordUser = userPassword
    }

    func setUserCredentials(email: String,
                            password: String) {

        if emailUser != "" && passwordUser != "" {
            userCurrentEmail = emailUser
            userCurrentPassword = passwordUser
        } else {
            userCurrentEmail = email
            userCurrentPassword = password
        }
    }

    func isCredentialsValid(email: String, password: String) -> Bool {
        var isUserCredentialsValid = false

        if userCurrentEmail.isEmpty || userCurrentPassword.isEmpty {
            delegate?.showError(errorMessage: "Please fill in your email and password")
        } else {
            isUserCredentialsValid = isUserEmailValid(email: email)
        }
        return isUserCredentialsValid
    }

    func isUserEmailValid(email: String) -> Bool {
        return isValidEmail(email: email)
    }

    func isPasswordLongEnough(email: String,
                              password: String) -> Bool {

        var isUserPasswordValid = false

        if !isValidPassword(password: userCurrentPassword) {
            isUserPasswordValid = false
        } else {
            isUserPasswordValid = true
        }
        return isUserPasswordValid
    }

    func loginUser(email: String, password: String) {
        setUserCredentials(email: email, password: password)
        let isUserCredentialsValid = isCredentialsValid(email: email,
                                                   password: password)
      
        let isUsersPasswordValid = isPasswordLongEnough(email: email,
                                                        password: password)

        if !isUserCredentialsValid || !isUsersPasswordValid {
            self.delegate?.showError(errorMessage: "Incorrect email or Password")
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
