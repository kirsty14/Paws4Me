//
//  PetRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

class GetPetDataRepository: Repositable {

    // MARK: - Fetch Json Object from API
    func fetchPetDataResults(method: HTTPMethod, endpoint: String, completionHandler: @escaping PetResult) {
        guard let request = URL(string: endpoint) else { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.serverError))
                    }
                    return
                }
                let object = try JSONDecoder().decode(AdoptPet.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(Result.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(Result.failure(.parsingError))
                }
            }
        }.resume()
    }
}
