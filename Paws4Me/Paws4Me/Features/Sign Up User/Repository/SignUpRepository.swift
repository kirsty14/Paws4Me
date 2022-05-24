//
//  SignUpRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/20.
//

import Foundation
import Firebase

typealias SignUpResult = (Result<Bool, APIError>) -> Void
typealias SaveUserResult = (Result<Bool, FirebaseError>) -> Void

class SignUpRepository {

    func signUpUser(email: String,
                    password: String,
                    completionHandler: @escaping SignUpResult) {
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

    func addUserToFirebase(name: String,
                           surname: String,
                           cellphone: String,
                           address: String,
                           completionHandler: @escaping SaveUserResult) {
        DispatchQueue.main.async {
            if let userId = Auth.auth().currentUser?.uid {
                Constants.firestoreDatabase.collection(FStoreUser.userCollectionName).document(userId).setData( [
                    FStoreUser.name: name,
                    FStoreUser.surname: surname,
                    FStoreUser.cellphone: cellphone,
                    FStoreUser.address: address,
                    FStoreUser.userID: userId]) { (error) in
                        if error != nil {
                            completionHandler(.failure(.savingError))
                        } else {
                            completionHandler(Result.success(true))
                        }
                    }
            }
        }
    }
}
