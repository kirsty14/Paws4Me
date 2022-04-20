//
//  SignInRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/20.
//

import Foundation
import Firebase

typealias SignInResult = (Result<Bool, APIError>) -> Void

class SignInRepository {
    func signInUser(email: String, password: String, completionHandler: @escaping SignInResult) {
        DispatchQueue.main.async {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if error != nil {
                completionHandler(.failure(.serverError))
            } else {
                completionHandler(Result.success(true))
            }
        }
        }
    }
}
