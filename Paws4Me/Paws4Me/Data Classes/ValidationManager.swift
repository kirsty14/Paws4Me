//
//  ValidationManager.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/05/16.
//

import Foundation
import UIKit

class ValidationManager {

    func isValidName(name: String) -> Bool {
        let nameRegEx =  "[a-zA-Z]{2,}"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePredicate.evaluate(with: name)
    }

    func isValidSurname(surname: String) -> Bool {
        let surnameRegEx =  "[a-zA-Z]{2,}"
        let surnamePredicate = NSPredicate(format: "SELF MATCHES %@", surnameRegEx)
        return surnamePredicate.evaluate(with: surname)
    }

    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "(?=.*[0-9a-zA-Z]).{6,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }

    func isValidAddress(address: String) -> Bool {
        let addressRegEx =  "^[#.0-9a-zA-Z/s,-]+$"
        let addressPredicate = NSPredicate(format: "SELF MATCHES %@", addressRegEx)
        return addressPredicate.evaluate(with: address)
    }

    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePredicate.evaluate(with: phoneNumber)
    }
}
