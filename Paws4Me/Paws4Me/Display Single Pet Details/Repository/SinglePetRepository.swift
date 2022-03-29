//
//  SinglePetRepository.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/29.
//

import Foundation
import UIKit

class SinglePetRepository {

    // MARK: - Vars/Lets
    typealias FetchSavedPets = (Result<[Pet], LocalDatabaseError>) -> Void
    private let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Fetch local database data
     func isPetSaved(petName: String) -> Bool {
        var isPetSaved = false
        do {
            guard let pets = try viewContext?.fetch(Pet.fetchRequest()) else { return  false}

            for savedPet in pets where savedPet.petName == petName {
                isPetSaved = true
            }
        } catch {
            isPetSaved = false
        }
        return isPetSaved
    }
}
