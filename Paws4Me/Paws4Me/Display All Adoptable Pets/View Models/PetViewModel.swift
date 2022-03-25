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
    func show(error: String)
}

class GetAllPetDataViewModel {

    // MARK: - Vars/Lets
    private var petRepository: GetPetDataRepository?
    private weak var delegate: PetViewModelDelegate?
    private var filteredPetObject: AdoptPet?
    private var adoptPetObject: AdoptPet?
    private var isSingleSearch = false
    private var isFilterSearch = true
    private var indexSinglePet: Int?
    private var selectedGender: String = ""
    private var animalType = ""

    // MARK: - Constructor
    init(repository: GetPetDataRepository,
         delegate: PetViewModelDelegate) {
        self.petRepository = repository
        self.delegate = delegate
    }

    // MARK: - Functions
    // MARK: - Functions Fetch Json Object
    func fetchPetDataResults() {
        petRepository?.fetchPetDataResults(method: .GET, endpoint: Constants.adoptURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let petData):
                    self?.adoptPetObject = petData
                    self?.filteredPetObject = petData
                    self?.delegate?.reloadView()
                case .failure(let error):
                    self?.delegate?.show(error: error.rawValue)
                }
            }
        }
    }

    // MARK: - Tableview Functions
    var petCount: Int {
        return filteredPetObject?.page?.count ?? 0
    }

    func objectFilteredPet() -> AdoptPet? {
        return filteredPetObject
    }

    func singleSearch() -> Bool {
        return isSingleSearch
    }

    func filterSearch() -> Bool {
        return isFilterSearch
    }

    func singlePetIndex() -> Int? {
        return indexSinglePet
    }

    // MARK: - Search Pet by name
    func setPetSearchName(petSearchText: String?) {
        guard let searchPetText = petSearchText?.lowercased()  else {
            filteredPetObject = adoptPetObject
            return
        }

        searchPetName(searchText: searchPetText)
    }

    func searchPetName(searchText: String) {
        isSingleSearch = true
        guard let petObject = adoptPetObject else { return }

        filteredPetObject?.page = petObject.page?.filter { $0.name?.lowercased().starts(with: searchText)
            ??  false}

        guard let filteredPet = filteredPetObject else { return }
        setIndexForSpecificPetName(searchText: searchText, filteredPetObject: filteredPet)

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        }
    }

    func setIndexForSpecificPetName (searchText: String, filteredPetObject: AdoptPet) {
        indexSinglePet =  filteredPetObject.page?.firstIndex(
            where: { $0.name?.lowercased().starts(with: searchText) ??  false })
    }

    // MARK: - Search Pet by Category, Gender
    func setGender(gender: String) {
        selectedGender = gender
    }

    func searchPetCategoryType(_ petCategoryType: String) {
        if petCategoryType.isEmpty && selectedGender.isEmpty {
            filteredPetObject = adoptPetObject
        } else {
            guard let petObject = adoptPetObject else {
                return
            }
            let petAge = getAgeFromPetCategoryType(_: petCategoryType)
            searchPet(petCategoryType: petCategoryType, gender: selectedGender, petAge: petAge)
            if filteredPetObject == nil {
                filteredPetObject = petObject
            }
        }
    }

    func getAgeFromPetCategoryType(_ petCategoryType: String) -> String {
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
        guard adoptPetObject != nil else {
            return
        }
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
    func filterOnlyWithGender() {
        guard let petObject = adoptPetObject else { return }
        filteredPetObject?.page = petObject.page?.filter {
            $0.sex?.lowercased() == selectedGender}

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        } else {
            isFilterSearch = true
        }
    }

    func filterOnlyWithAgeAndType(type: String, petAge: String) {
        guard let petObject = adoptPetObject else {
            return
        }
        filteredPetObject?.page = petObject.page?.filter {
            $0.age?.lowercased() == petAge &&
            $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()}

        if filteredPetObject == nil {
            filteredPetObject = adoptPetObject
        } else {
            isFilterSearch = true
        }
    }

    func filterWithAgeTypeGender(type: String, gender: String, petAge: String) {
        guard let petObject = adoptPetObject else {
            return
        }
        filteredPetObject?.page = petObject.page?.filter {
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
