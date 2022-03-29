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

enum HTTPMethod {
    case GET
    case POST
}
