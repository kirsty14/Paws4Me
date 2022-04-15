//
//  PetViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/24.
//

import Foundation

// MARK: - PetViewModel Delegate
protocol PetViewModelDelegate: AnyObject {
    func reloadView()
    func showError(error: String)
}

class AllPetDataViewModel {

    // MARK: - Vars/Lets
    private var petRepository: SearchPetRepositoryType?
    private weak var delegate: PetViewModelDelegate?
    private var filteredPetObject: AdoptPet?
    private var adoptPetObject: AdoptPet?
    private var isSingleSearch = false
    private var isFilterSearch = true
    private var indexSinglePet: Int?
    private var selectedGender: String = ""
    private var animalType = ""

    // MARK: - Constructor
    init(repository: SearchPetRepositoryType,
         delegate: PetViewModelDelegate) {
         self.petRepository = repository
         self.delegate = delegate
    }

    // MARK: - Functions
    func fetchPetDataResults() {
        petRepository?.fetchPetDataResults(method: .GET, endpoint: Constants.adoptURL) { [weak self] result in
                switch result {
                case .success(let petData):
                    self?.adoptPetObject = petData
                    self?.filteredPetObject = petData
                    self?.delegate?.reloadView()
                case .failure(let error):
                    self?.delegate?.showError(error: error.rawValue)
                }
        }
    }

    func setPetType(petType: String) {
        animalType = petType
    }

    var petType: String {
        return animalType
    }

    // MARK: - Tableview Functions
    var petCount: Int {
        return filteredPetObject?.page?.count ?? 0
    }

    var objectFilteredPet: AdoptPet? {
        return filteredPetObject
    }

    var singleSearch: Bool {
        return isSingleSearch
    }

    var filterSearch: Bool {
        return isFilterSearch
    }

    var singlePetIndex: Int? {
        return indexSinglePet
    }

    // MARK: - Search
    func setPetSearchName(petSearchText: String?) {

        guard let filteredPet = filteredPetObject else { return }
        setIndexForSpecificPetName(searchText: petSearchText?.lowercased() ?? "", filteredPet: filteredPet )
        searchPetName(searchText: petSearchText?.lowercased() ?? "")
    }

    func setIndexForSpecificPetName (searchText: String, filteredPet: AdoptPet) {
        indexSinglePet = filteredPet.page?.firstIndex(where: {$0.name?.lowercased().starts(with: searchText) ?? false })
    }

    func searchPetName(searchText: String) {
        isSingleSearch = true

        filteredPetObject?.page = adoptPetObject?.page?.filter { $0.name?.lowercased().starts(with: searchText)
            ??  false}

        if filteredPetObject != nil {
        guard let filteredPet = filteredPetObject else { return }
        setIndexForSpecificPetName(searchText: searchText, filteredPet: filteredPet)
        }

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        }
    }

    // MARK: - Search Pet by Category, Gender
    func setGender(gender: String) {
        selectedGender = gender
    }

    func searchPetCategoryType(_ petCategoryType: String) {
        if petCategoryType.isEmpty && selectedGender.isEmpty {
            filteredPetObject = adoptPetObject
        } else {

            let petAge = ageFromPetCategoryType(_: petCategoryType)
            searchPet(petCategoryType: petCategoryType, gender: selectedGender, petAge: petAge)
            if filteredPetObject == nil {
                filteredPetObject = adoptPetObject
            }
        }
    }

    func ageFromPetCategoryType(_ petCategoryType: String) -> String {
        var petAge = ""
        let petTypeSelected = SpeciesName(rawValue: petCategoryType)

        switch petTypeSelected {
        case .kitten, .puppy:
            petAge = "young"
        case .cat, .dog:
            petAge = "adult"
        case .none:
            petAge = "adult"
        }
        return petAge
    }

    func searchPet(petCategoryType: String, gender: String, petAge: String) {

        let petTypeLowercase = petCategoryType.lowercased()
        let isGenderValid = selectedGender != ""
        let isPetTypeValid = petCategoryType != ""

        if isPetTypeValid && isGenderValid {
            filterWithAgeTypeGender(type: petTypeLowercase, gender: selectedGender, petAge: petAge)
        } else if isGenderValid {
            filterOnlyWithGender()
        } else if isPetTypeValid {
            filterOnlyWithAgeAndType(type: petTypeLowercase, petAge: petAge)
        } else {
            filteredPetObject = adoptPetObject
        }
    }

    // MARK: - Filter Search
    private func filterOnlyWithGender() {

        filteredPetObject?.page = adoptPetObject?.page?.filter {
            $0.sex?.lowercased() == selectedGender}

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        } else {
            isFilterSearch = true
        }
    }

    private func filterOnlyWithAgeAndType(type: String, petAge: String) {
        filteredPetObject?.page = adoptPetObject?.page?.filter {
            $0.age?.lowercased() == petAge &&
            $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()}

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        } else {
            isFilterSearch = true
        }
    }

    private func filterWithAgeTypeGender(type: String, gender: String, petAge: String) {
        filteredPetObject?.page = adoptPetObject?.page?.filter {
            $0.age?.lowercased() == petAge &&
            $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()
            && $0.sex?.lowercased() == gender}

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        } else {
            isFilterSearch = true
        }
    }
}
