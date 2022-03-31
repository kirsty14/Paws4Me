//
//  Repository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/25.
//

import Foundation
import UIKit

class SavedPetDataRepository {

    // MARK: - Vars/Lets
    typealias PetFetchSavedResult = (Result<[Pet], LocalDatabaseError>) -> Void
    typealias SavePetResults = (Result<[Pet], LocalDatabaseError>) -> Void
    typealias DeletePetResults = (Result<[Pet], LocalDatabaseError>) -> Void
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var pets: [Pet]? = []
    private var namePet = ""
    private var imagePet = ""

    // MARK: - Local database Fetch Function
    func fetchSavedPets(completionHandler: @escaping PetFetchSavedResult) {
        DispatchQueue.main.async {
        do {
            self.pets = try self.context?.fetch(Pet.fetchRequest())
            guard let savedPets = self.pets else { return }
            completionHandler(Result.success(savedPets))
        } catch _ as NSError {
            completionHandler(Result.failure(.retrievedPetsSavedError))
        }
        }
    }

    // MARK: - Local database Save Function
    func savePets(namePet: String, imagePet: String, completionHandler: @escaping SavePetResults) {

        guard let petContext = self.context else { return }
        let petObject = Pet(context: petContext)
        petObject.petName = namePet
        petObject.petImage = imagePet

        DispatchQueue.main.async {
        do {
            guard let petContext = self.context,
                  let savedPets = self.pets else { return }
            try petContext.save()
            completionHandler(Result.success(savedPets))
        } catch _ as NSError {
            completionHandler(Result.failure(.savePetsError))
        }
        }
    }

    // MARK: - Local database Delete Functions
    func deleteSavedPet(petToRemove: Pet, completionHandler: @escaping DeletePetResults) {
        self.context?.delete(petToRemove)
        guard let savedPets = self.pets else { return }

        // DispatchQueue.main.async {
        do {
            try self.context?.save()
            completionHandler(Result.success(savedPets))
        } catch _ as NSError {
            completionHandler(Result.failure(.deletePetsError))
        }
       // }
    }
}
