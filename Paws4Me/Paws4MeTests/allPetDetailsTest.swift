//
//  allPetDetailsTest.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/04/09.
//

import XCTest
@testable import Paws4Me

class AllPetDetailsTest: XCTestCase {

    private var petViewModel: AllPetDataViewModel!
    private var mockPetDelegate: MockPetAllDelegate!
    private var mockPetRepository: MockPetDataRepository!

    override func setUp() {
        mockPetDelegate = MockPetAllDelegate()
        mockPetRepository = MockPetDataRepository()
        petViewModel = AllPetDataViewModel(repository: mockPetRepository,
                                           delegate: mockPetDelegate)
    }

    // MARK: - Tableview data
    func testAllPetDetailsCount_ReturnsIncorrectValue() {
        petViewModel.fetchPetDataResults()
        XCTAssertEqual(petViewModel.petCount, 0)
    }

    func testAllPetDetailsCount_ReturnsCorrectValue() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        XCTAssertEqual(petViewModel.petCount, 1)
    }

    func testPetObject_ReturnsNil() {
        petViewModel.fetchPetDataResults()
        petViewModel.setPetSearchName(petSearchText: "Sammy")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testPetObject_ReturnsNotNill() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setPetSearchName(petSearchText: "Baba")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testSearchPetObject_ReturnsNil() {
        petViewModel.searchPetName(searchText: "")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    // MARK: - Search pet
    func testPetName_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setPetSearchName(petSearchText: "")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testSearchPetBySpecificName_ReturnsNil() {
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetName(searchText: "Sammy")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testSearchPetBySpecificName_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetName(searchText: "Baba")
        isSingleSearchTrue()
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func isSingleSearchTrue() {
        let isSingleSerch = petViewModel.singleSearch
        XCTAssertTrue(isSingleSerch)
    }

    func testSearchPetBySpecificName_ReturnsNilIndex() {
        petViewModel.fetchPetDataResults()
        petViewModel.setPetSearchName(petSearchText: "Sammy")
        XCTAssertNil(petViewModel.singlePetIndex)
    }

    func testSearchPetBySpecificName_ReturnsNotNilIndex() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setPetSearchName(petSearchText: "Baba")
        XCTAssertNotNil(petViewModel.singlePetIndex)
    }

    func testAdoptPetObject_ReturnsNil() {
        petViewModel.searchPetName(searchText: "Baba")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testFetchSearchResultsFailure() {
        petViewModel.fetchPetDataResults()
        XCTAssertFalse(mockPetDelegate.reloadViewCalled)
        XCTAssert(mockPetDelegate.errorCalled)
    }

    func testFetchSearchResultsSuccess() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        XCTAssert(mockPetDelegate.reloadViewCalled)
        XCTAssertFalse(mockPetDelegate.errorCalled)
    }

    func testTypeIsCorrectlySet() {
        setType()
        XCTAssertEqual(petViewModel.petType, "Cat")
    }

    func testIndexForSpecificPetName_IsEqual() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setIndexForSpecificPetName(searchText: "baba", filteredPet: setMockData)
        XCTAssertEqual(petViewModel.singlePetIndex, 0)
    }

    func testPetSearchName_IsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetName(searchText: "Baba")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    // MARK: - Filter search
    func testsearchPetCategoryType_ReturnsNotNil() {
        setGender()
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetCategoryType("Cat")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenEmptyValues_ReturnsNotNil() {
        petViewModel.setGender(gender: "")
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetCategoryType("")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenOnlyGender_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        setGender()
        petViewModel.fetchPetDataResults()
        petViewModel.searchPet(petCategoryType: "", gender: "Female", petAge: "")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenOnlyGenderNoPetObject_ReturnsNil() {
        setGender()
        petViewModel.searchPet(petCategoryType: "", gender: "Female", petAge: "")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenNoGender_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPet(petCategoryType: "Cat", gender: "", petAge: "Adult")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenOnlyAgeType_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.setPetType(petType: "cat")
        petViewModel.fetchPetDataResults()
        petViewModel.searchPet(petCategoryType: petViewModel.petType, gender: "Female", petAge: "adult")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenNoAgeCategory_ReturnsNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPet(petCategoryType: "", gender: "Female", petAge: "")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testIfPetSearchGivenOnlyGender_ReturnsTrue() {
        mockPetRepository.shouldPass = true
        setGender()
        petViewModel.fetchPetDataResults()
        petViewModel.searchPet(petCategoryType: "", gender: "Female", petAge: "")
        XCTAssertTrue(petViewModel.filterSearch)
    }

    func testSearchPetCategoryPetObject_ReturnsNil() {
        petViewModel.searchPet(petCategoryType: "", gender: "", petAge: "")
        XCTAssertTrue(petViewModel.filterSearch)
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testsearchPetCategoryTypeIs_ReturnsNil() {
        petViewModel.searchPetCategoryType("Cat")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testaAgeForPuppy_ReturnsNotNil() {
        setGender()
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetCategoryType("Puppy")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testAgeForNoneI_ReturnsNotNil() {
        setGender()
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetCategoryType("none")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenTypeAgePetObject_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setGender(gender: "")
        setType()
        petViewModel.searchPet(petCategoryType: "Cat", gender: "", petAge: "Adult")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenTypeAge_ReturnsNotNil() {
        petViewModel.setGender(gender: "")
        setType()
        petViewModel.searchPet(petCategoryType: "Cat", gender: "", petAge: "Adult")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenGender_ReturnsNil() {
        petViewModel.setPetType(petType: "")
        setGender()
        petViewModel.searchPet(petCategoryType: "", gender: "Female", petAge: "")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testPetObjectGivenNoParamaterValues_ReturnsNil() {
        petViewModel.searchPet(petCategoryType: "", gender: "", petAge: "")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testFilterOnlyWithAgeAndType_ReturnsNotNil() {
        mockPetRepository.shouldPass = true
        petViewModel.fetchPetDataResults()
        petViewModel.setPetType(petType: "Dog")
        petViewModel.searchPet(petCategoryType: petViewModel.petType, gender: "", petAge: "Adult")
        XCTAssertNotNil(petViewModel.objectFilteredPet)
    }

    func testFilterOnlyWithAgeAndType_ReturnsNil() {
        petViewModel.setPetType(petType: "Dog")
        petViewModel.searchPet(petCategoryType: petViewModel.petType, gender: "", petAge: "Adult")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testFilterWithAgeTypeGender_ReturnsNil() {
        setGender()
        petViewModel.setPetType(petType: "Dog")
        petViewModel.searchPet(petCategoryType: petViewModel.petType, gender: "", petAge: "Adult")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func setGender() {
        petViewModel.setGender(gender: "Female")
    }

    func setType() {
        petViewModel.setPetType(petType: "Cat")
    }
}

class MockPetDataRepository: SearchPetRepositoryType {
    var shouldPass = false
    func fetchPetDataResults(method: HTTPMethod, endpoint: String, completionHandler: @escaping PetResult) {
        if shouldPass {
            let mockData = setMockData
            completionHandler(.success(mockData))
        } else {
            completionHandler(.failure(.serverError))
        }
    }
}

private var setMockData: AdoptPet {
    return AdoptPet(count: 1, page: [Page(age: "Adult", center: Center(city: "JHB", id: 1, lat: 12.89, lon: 13.67,
                    name: "Center JHB", services: "none", state: "SA", zipcode: "2456"),
                    color: "Ginger", desc: "Pretty cat", petId: 1, name: "Baba", animalImage: "link", sex: "Female",
                    animalSpeciesBreed: SpeciesBreed(petBreedName: "Tabby", speciesID: 1,
                                                     petSpecies: "Cat", petYouthName: "Kitten"))])
}

class MockPetAllDelegate: PetViewModelDelegate {
    var reloadViewCalled = false
    var errorCalled = false

    func reloadView() {
        reloadViewCalled = true
    }

    func showError(error: String) {
        errorCalled = true
    }
}
