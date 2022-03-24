//
//  petSingelViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation
import UIKit

class SinglePetViewModel {

    // MARK: - Vars/Lets
    private var singlePet: AdoptPet?
    private var indexSinglePet: Int = 0

    // MARK: - Functions
    func setIndexForSpecificPetName (searchText: String, filteredPetObject: AdoptPet) -> Int? {
        let indexSinglePet =  filteredPetObject.page?.firstIndex(
            where: { $0.name?.lowercased().starts(with: searchText) ??  false })
        return indexSinglePet
    }

    func getSinglePetIndex(singleSearch: Bool, filterSearch: Bool, tableView: UITableView, indexPet: Int?) -> Int {
        var indexRow = 0
        if !singleSearch || !filterSearch {
            guard let rowIndex = tableView.indexPathForSelectedRow?.row else { return 0 }
            indexRow = rowIndex
        } else {
            guard let indexPet = indexPet else { return 0 }
            indexRow = indexPet
        }
        return indexRow
    }

    // MARK: - Save single pet details
    func setSelectedPetIndex(indexPet: Int) {
        indexSinglePet = indexPet
    }

    func setSinglePetObject(petObject: AdoptPet) {
        singlePet = petObject
    }

    // MARK: - Get single pet details

    func getSinglePetName() -> String? {
        guard let petName = singlePet?.page?[indexSinglePet].name else { return "" }
        return petName
    }

    func getSinglePetAge () -> String? {
        guard let petAge = singlePet?.page?[indexSinglePet].age else { return "" }
        return petAge
    }

    func getSinglePetBreed () -> String? {
        guard let petBreed = singlePet?.page?[indexSinglePet].animalSpeciesBreed?.petBreedName
        else { return "" }
        return petBreed
    }

    func getSinglePetGender () -> String? {
        guard let petGender = singlePet?.page?[indexSinglePet].sex else { return "" }
        return petGender
    }

    func getSinglePetImage () -> String? {
        guard let petImage = singlePet?.page?[indexSinglePet].animalImage else { return "" }
        return petImage
    }

}
