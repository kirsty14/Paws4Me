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

class SignUpViewModel: ValidationManager {

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

    init(delegate: SignUpViewModelDelegate,
         signUpRepository: SignUpRepository) {
        self.delegate = delegate
        self.signUpRepository = signUpRepository
    }

    // MARK: - Functions

    func isUserDetailsValid(name: String, surname: String, phone: String, address: String) -> Bool {
        var isUserDetailsValid = false
        if name.isEmpty || surname.isEmpty || phone.isEmpty || address.isEmpty {
            delegate?.showError(errorMessage: "Please fill in all your details")
        } else {
            isUserDetailsValid = validateUserDetails(name: name, surname: surname, phone: phone, address: address)
        }
        return isUserDetailsValid
    }

    func validateUserDetails(name: String, surname: String, phone: String, address: String) -> Bool {
        var validUserDetails = false

        let isNameValid = isValidName(name: name)
        let isSurnameValid = isValidSurname(surname: surname)
        let isUserAddressValid = isValidAddress(address: address)
        let isUserPhoneNumberValid = isValidPhoneNumber(phoneNumber: phone)

        if isNameValid && isSurnameValid && isUserAddressValid && isUserPhoneNumberValid {
            validUserDetails = true
        } else {
            delegate?.showError(errorMessage: "Your details are invalid, Try Again")
        }

        return validUserDetails
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

    func addUserToFirebase(name: String,
                           surname: String,
                           cellphone: String,
                           address: String) {
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
        let isUserEmailValid = isValidEmail(email: userEmail)
        let isUserPasswordValid = isValidPassword(password: userPassword)

        if !isUserCredentialsEmpty && isUserEmailValid && isUserPasswordValid {
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
