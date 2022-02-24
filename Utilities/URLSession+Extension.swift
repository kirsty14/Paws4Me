//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import Foundation

extension URLSession {
    // Known errors we want to listen for
    enum CustomError: Error {
        case invalidResponse
        case invalidRequest
        case invalidUrl
        case invalidData
    }
    
    // Custom function that we want to now use
    func makeRequest<Generic: Codable>(url: URLRequest?,
                                       model: Generic.Type,
                                       completion: @escaping (Result<Generic, Error>) -> Void) {
        
            // Ensuring the URL is safe and we can use it
            guard let endpointUrl = url else {
                completion(.failure(CustomError.invalidUrl))
                return
            }
            
            // This task processes the url & simple cancelable asynchronous interface to receiving data
            let apiTask = self.dataTask(with: endpointUrl as URLRequest) { data, _, error in
                
                // Ensures that the data recieved is safe to use
                guard let safeData = data else {
                    
                    // Confirms if there is an error else custom error we created
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                
                do {
                    // Runs JSON deserialization from the safe data into the generic model we pass in
                    let result = try JSONDecoder().decode(model.self, from: safeData)
                    
                    DispatchQueue.main.async {
                        // Tells the code we are complete and return what we deserialization
                        completion(.success(result))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            // Resume is execute request in this instant
            apiTask.resume()
    }
}
