//
//  petLocaldatabaseViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/25.
//

import Foundation

// MARK: - PetLocalDatabaseViewModel Delegate
protocol PetLocalDatabaseViewModelDelegate: AnyObject {
    func reloadView()
    func showError(errorTitle: String, errorMessage: String, action: LocalDatabaseError)
}

class PetLocaldatabaseViewModel {

    // MARK: - Vars/Lets
    private var petLocalDatabaseRepository: SavedPetDataRepository?
    private weak var delegate: PetLocalDatabaseViewModelDelegate?
    private var pets: [Pet]? = []
    private var namePet = ""
    private var imagePet = ""
    var isDeleteSucess = false

    var nameSinglePet: String? {
        return namePet
    }

    var imageSinglePet: String? {
       return imagePet
    }

    // MARK: - Constructor
    init(repository: SavedPetDataRepository,
         delegate: PetLocalDatabaseViewModelDelegate) {
        self.petLocalDatabaseRepository = repository
        self.delegate = delegate
    }

    // MARK: - Functions
    func set(petName: String) {
        namePet = petName
    }

    func set(imagePet: String) {
        self.imagePet = imagePet
    }

    // MARK: - Tableview data
    var petSavedCount: Int {
        return pets?.count ?? 0
    }

    var isPetSucessDeleted: Bool {
        return isDeleteSucess
    }

    func savedPet(at index: Int) -> Pet? {
        pets?[index]
    }

    func petNameSaved(pet: Pet) -> String {
        return pet.value(forKeyPath: "petName") as? String ?? ""
    }

    func petImageSaved(pet: Pet) -> String {
        return pet.value(forKeyPath: "petImage") as? String ?? ""
    }

    // MARK: - Functions Fetch local database Object
    func fetchPetDataResults() {
        petLocalDatabaseRepository?.fetchSavedPets { [weak self] savedPets in
            switch savedPets {
            case .success(let savedPetData):
                self?.pets = savedPetData
                self?.delegate?.reloadView()
            case .failure:
                self?.delegate?.showError(errorTitle: "Unable to retreive all your saved pets",
                                          errorMessage: "There was a problem retrieving your pets",
                                          action: .retrievedPetsSavedError)
            }
        }
    }

    // MARK: - Function Save pet in local database
    func savePetInLocalDatabase(name: String, image: String) {
        petLocalDatabaseRepository?.savePets(namePet: name, imagePet: image ) { [weak self] savedPets in
            switch savedPets {
            case .success:
                self?.delegate?.reloadView()
            case .failure:
                self?.delegate?.showError(errorTitle: "Unable to save \(name)",
                                          errorMessage: "There was a problem savings",
                                          action: .savePetsError)
            }
            self?.fetchPetDataResults()
        }
    }

    // MARK: - Function delete pet in local database
    func deletePetLocaldatabase(petToRemove: Pet) {
        petLocalDatabaseRepository?.deleteSavedPet(petToRemove: petToRemove) { [weak self] savedPets in
            switch savedPets {
            case .success:
                    // self?.fetchPetDataResults()
                    self?.isDeleteSucess = true
            case .failure:
                self?.isDeleteSucess = false
            }
        }
    }
}
