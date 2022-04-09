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

    func testAllPetDetailsCountReturnsInCorrectValue() {
        petViewModel.fetchPetDataResults()
        XCTAssertEqual(petViewModel.petCount, 0)
    }

    func testSearchPetBySpecificNameReturnsNullPet() {
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetName(searchText: "Sammy")
        XCTAssertNil(petViewModel.objectFilteredPet)
    }

    func testSearchPetBySpecificNameReturnsNullIndex() {
        petViewModel.fetchPetDataResults()
        petViewModel.searchPetName(searchText: "Baba")
        XCTAssertNil(petViewModel.singlePetIndex)
    }

    func testSearchResultsFailure() {
        petViewModel.fetchPetDataResults()
        mockPetDelegate.showError(error: "Error")
        XCTAssertFalse(mockPetDelegate.reloadViewCalled)
        XCTAssert(mockPetDelegate.errorCalled)
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
