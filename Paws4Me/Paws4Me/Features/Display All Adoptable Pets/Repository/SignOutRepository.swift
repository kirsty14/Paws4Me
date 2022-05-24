//
//  SignOutRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/05/03.
//

import Foundation
import Firebase

typealias LogOutAction = (Result<Bool, APIError>) -> Void

protocol SignOutRepositroyType: AnyObject {
    func logUserOut( completionHandler: @escaping LogOutAction)
}

class SingOutRepository: SignOutRepositroyType {
    // MARK: - Local database Function
     func logUserOut( completionHandler: @escaping LogOutAction) {
         do {
             try Auth.auth().signOut()
             DispatchQueue.main.async {
                 completionHandler(Result.success(true))
             }
         } catch {
             DispatchQueue.main.async {
                 completionHandler(Result.failure(.serverError))
             }
         }
    }
}
