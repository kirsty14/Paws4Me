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
        var isNameValid = true
        let nameRegex =  "[a-zA-Z]{2,}"
          do {
              let regex = try NSRegularExpression(pattern: nameRegex)
              let nsString = name as NSString
              let results = regex.matches(in: name, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isNameValid = false
              }
          } catch {
              isNameValid = false
          }
          return  isNameValid
      }

    func isValidSurname(surname: String) -> Bool {
        var isSurnameValid = true
        let surnameRegex =  "[a-zA-Z]{2,}"
          do {
              let regex = try NSRegularExpression(pattern: surnameRegex)
              let nsString = surname as NSString
              let results = regex.matches(in: surname, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isSurnameValid = false
              }
          } catch {
              isSurnameValid = false
          }
          return  isSurnameValid
      }

    func isValidEmailAddress(emailAddress: String) -> Bool {
          var isEmailValid = true
          let emailRegex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
          do {
              let regex = try NSRegularExpression(pattern: emailRegex)
              let nsString = emailAddress as NSString
              let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isEmailValid = false
              }
          } catch {
              isEmailValid = false
          }
          return  isEmailValid
      }

    func isValidPassword(password: String) -> Bool {
          var isPasswordRegexValid = true
          let passwordRegex = "(?=.*[0-9a-zA-Z]).{6,}"
          do {
              let regex = try NSRegularExpression(pattern: passwordRegex)
              let nsString = password as NSString
              let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isPasswordRegexValid = false
              }
          } catch {
              isPasswordRegexValid = false
          }
          return isPasswordRegexValid
      }

    func isValidAddress(address: String) -> Bool {
          var isAddressRegexValid = true
        let addressRegex =  "^[#.0-9a-zA-Z/s,-]+$"
          do {
              let regex = try NSRegularExpression(pattern: addressRegex)
              let nsString = address as NSString
              let results = regex.matches(in: address, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isAddressRegexValid = false
              }
          } catch {
              isAddressRegexValid = false
          }
          return  isAddressRegexValid
      }

    func isValidPhoneNumber(phoneNumber: String) -> Bool {
          var isPhoneNumberValid = true
          let phoneNumberRegex = "^\\d{3}-\\d{3}-\\d{4}$"
          do {
              let regex = try NSRegularExpression(pattern: phoneNumberRegex)
              let nsString = phoneNumber as NSString
              let results = regex.matches(in: phoneNumber, range: NSRange(location: 0, length: nsString.length))

              if results.count == 0 {
                  isPhoneNumberValid = false
              }
          } catch {
              isPhoneNumberValid = false
          }
          return  isPhoneNumberValid
      }
}
