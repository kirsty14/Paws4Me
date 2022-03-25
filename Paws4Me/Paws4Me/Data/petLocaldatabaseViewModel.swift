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
    func show(errorTitle: String, errorMessage: String)
}

class PetLocaldatabaseViewModel {

    // MARK: - Vars/Lets
    private var petLocalDatabaseRepository: SavedPetDataRepository?
    private weak var delegate: PetLocalDatabaseViewModelDelegate?
    private var pets: [Pet]? = []

    // MARK: - Constructor
    init(repository: SavedPetDataRepository,
         delegate: PetLocalDatabaseViewModelDelegate) {
        self.petLocalDatabaseRepository = repository
        self.delegate = delegate
    }

    // MARK: - Functions Fetch Json Object
    func fetchPetDataResults() {
        guard let petsSaved = pets else { return }
        petLocalDatabaseRepository?.fetchSavedPets(savedPets: petsSaved) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let savedPetData):
                    self?.pets = savedPetData
                    self?.delegate?.reloadView()
                case .failure:
                    self?.delegate?.show(errorTitle: "Unable to retreive all your saved pets",
                                         errorMessage: "There was a problem retrieving")
                }
            }
        }
}
}
