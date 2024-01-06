//
//  ServiceErrors.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

enum APIError: String, Error {
    case internalError
    case serverError
    case parsingError
}

enum LocalDatabaseError: String, Error {
    case retrievedPetsSavedError
    case savePetsError
    case deletePetsError
}

enum FirebaseError: String, Error {
    case savingError
    case retrievalError
}

enum HTTPMethod {
    case GET
    case POST
}
