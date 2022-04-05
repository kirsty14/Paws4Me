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

    var singlePetName: String {
        return singlePet?.page?[indexSinglePet].name ?? ""
    }

    var singlePetAge: String {
        return singlePet?.page?[indexSinglePet].age ?? ""
    }

    var singlePetBreed: String {
       return singlePet?.page?[indexSinglePet].animalSpeciesBreed?.petBreedName  ?? ""
    }

    var singlePetGender: String {
        return singlePet?.page?[indexSinglePet].sex  ?? ""
    }

    var singlePetImage: String {
        return singlePet?.page?[indexSinglePet].animalImage  ?? ""
    }

    var singlePetIndex: Int? {
        return indexSinglePet
    }

    var singlePetObject: AdoptPet? {
        return singlePet
    }

    // MARK: - Constructor
    init(repository: SinglePetRepository) {
         self.singlePetRepository = repository
    }

    // MARK: - Functions
    func setIndexForSpecificPetName (searchText: String, filteredPetObject: AdoptPet) -> Int? {
        return filteredPetObject.page?.firstIndex(where: { $0.name?.lowercased().starts(with: searchText) ??  false })
    }

    func isPetSaved() -> Bool {
        guard let isPetSaved = singlePetRepository?.isPetSaved(petName: singlePetName) else { return false }
         return isPetSaved
    }

    func setSelectedPetIndex(indexPet: Int) {
        indexSinglePet = indexPet
    }

    func setSinglePetObject(petObject: AdoptPet) {
        singlePet = petObject
    }

}
