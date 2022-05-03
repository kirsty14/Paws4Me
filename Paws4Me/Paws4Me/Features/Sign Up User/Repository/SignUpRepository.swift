//
//  SignUpRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/20.
//

import Foundation
import Firebase

typealias SignUpResult = (Result<Bool, APIError>) -> Void

class SignUpRepository {
    func signUpUser(email: String, password: String, completionHandler: @escaping SignUpResult) {
        DispatchQueue.main.async {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if error != nil {
                    completionHandler(.failure(.serverError))
                } else {
                    completionHandler(Result.success(true))
                }
            }
        }
    }
}
