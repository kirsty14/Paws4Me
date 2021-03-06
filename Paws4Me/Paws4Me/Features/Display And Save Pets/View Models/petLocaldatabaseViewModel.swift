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
    func refreshPet()
}

class PetLocaldatabaseViewModel {

    // MARK: - Vars/Lets
    private var petLocalDatabaseRepository: SavedPetDataRepository?
    private weak var delegate: PetLocalDatabaseViewModelDelegate?
    private var pets: [Pet]? = []
    private var namePet = ""
    private var imagePet = ""
    private var isDeleteSucess = false

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

    func set(isPetDeleteSuccess: Bool) {
        isDeleteSucess = isPetDeleteSuccess
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

    // MARK: - Local Database function fetch
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

    // MARK: - Local Database function save
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

    // MARK: - Local Database function delete
    func deletePetLocaldatabase(petToRemove: Pet) {
        guard let petDeleteName = petToRemove.petName else { return }
        petLocalDatabaseRepository?.deleteSavedPet(petToRemove: petToRemove) { [weak self] savedPets in
            switch savedPets {
            case .success:
                self?.delegate?.refreshPet()
            case .failure:
                self?.delegate?.showError(errorTitle: "Unable to delete \(petDeleteName)?",
                                           errorMessage: "There was a problem deleting \(petDeleteName)",
                                           action: .deletePetsError)
            }
        }
    }
}
