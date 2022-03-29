//
//  petSingelViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

class SinglePetViewModel {

    // MARK: - Vars/Lets
    private var singlePet: AdoptPet?
    private var indexSinglePet: Int = 0
    private var singlePetRepository: SinglePetRepository?

    // MARK: - Constructor
    init(repository: SinglePetRepository) {
         self.singlePetRepository = repository
    }

    // MARK: - set single pet details
    func setIndexForSpecificPetName (searchText: String, filteredPetObject: AdoptPet) -> Int? {
        return filteredPetObject.page?.firstIndex(where: { $0.name?.lowercased().starts(with: searchText) ??  false })
    }

    func setSelectedPetIndex(indexPet: Int) {
        indexSinglePet = indexPet
    }

    func setSinglePetObject(petObject: AdoptPet) {
        singlePet = petObject
    }

    // MARK: - get single pet details
    var singlePetName: String? {
        return singlePet?.page?[indexSinglePet].name ?? ""
    }

    var singlePetAge: String? {
        return singlePet?.page?[indexSinglePet].age ?? ""

    }

    var singlePetBreed: String? {
       return singlePet?.page?[indexSinglePet].animalSpeciesBreed?.petBreedName  ?? ""
    }

    var singlePetGender: String? {
        return singlePet?.page?[indexSinglePet].sex  ?? ""
    }

    var singlePetImage: String? {
        return singlePet?.page?[indexSinglePet].animalImage  ?? ""
    }

    // MARK: - set single pet details
    func isPetSaved(petName: String) -> Bool {
        guard let isPetSaved = singlePetRepository?.isPetSaved(petName: petName) else { return false }
         return isPetSaved
    }

    func singlePetIndex() -> Int? {
        return indexSinglePet
    }

    func singlePetObject() -> AdoptPet? {
        return singlePet
    }
}
