//
//  Repositable.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

typealias PetResult = (Result<AdoptPet, APIError>) -> Void

protocol Repositable: AnyObject {
    func fetchPetDataResults(method: HTTPMethod, endpoint: String, completionHandler: @escaping PetResult)
}
