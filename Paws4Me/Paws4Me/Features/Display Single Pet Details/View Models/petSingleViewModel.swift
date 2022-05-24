//
//  petSingelViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

// MARK: - SignInViewModel Delegate
protocol SinglePetViewModelDelegate: AnyObject {
    func successRouting()
    func showError(errorMessage: String)
}

class SinglePetViewModel {

    // MARK: - Vars/Lets
    private var singlePet: AdoptPet?
    private var indexSinglePet: Int = 0
    private var singlePetRepository: SinglePetRepository?
    private weak var delegate: SinglePetViewModelDelegate?

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
    init(delegate: SinglePetViewModelDelegate, repository: SinglePetRepository) {
        self.delegate = delegate
        self.singlePetRepository = repository
    }

    // MARK: - Functions

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

    func addPetToFirebase() {
        singlePetRepository?.addPetToFirebase(name: singlePetName,
                                            age: singlePetAge,
                                            breed: singlePetBreed,
                                            gender: singlePetGender,
                                            image: singlePetImage) { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.successRouting()
            case .failure:
                self?.delegate?.showError(errorMessage: "Unable to save pet details")
            }
    }
    }
}
