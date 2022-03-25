//
//  Repository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/25.
//

import Foundation
import UIKit

class SavedPetDataRepository {

    typealias PetSavedResult = (Result<[Pet], LocalDatabaseError>) -> Void
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var pets: [Pet]? = []

    // MARK: - Fetch local database data

    func fetchSavedPets(savedPets: [Pet], completionHandler: @escaping PetSavedResult) {
        do {
            self.pets = try context?.fetch(Pet.fetchRequest())
            DispatchQueue.main.async {
                guard let savedPets = self.pets else { return }
                completionHandler(.success(savedPets))
            }

        } catch _ as NSError {
            DispatchQueue.main.async {
            completionHandler(.failure(.receiveSavedPetsError))
            }
        }
    }
}
