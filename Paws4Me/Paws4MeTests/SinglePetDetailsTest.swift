//
//  Paws4MeTests.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/02/23.
//

import XCTest
@testable import Paws4Me

class SinglePetDetailsTest: XCTestCase {

    private var singlePetViewmodel: SinglePetViewModel!
    private var mockSinglePetRepository: MockSinglePetRepository!

    override func setUp() {
        mockSinglePetRepository = MockSinglePetRepository()
        singlePetViewmodel = SinglePetViewModel(repository: mockSinglePetRepository)
  }

    func testSavedPetByName_ReturnsTrue() {
        mockSinglePetRepository.shouldPass = true
        var isSaved = mockSinglePetRepository.isPetSaved(petName: "Baba")
        mockSinglePetRepository.setMockData()
        XCTAssertEqual(singlePetViewmodel.singlePetName, "Baba")
    }

}

class MockSinglePetRepository: SinglePetRepository {
    var shouldPass = false
    var singlePetViewmodel = SinglePetViewModel(repository: MockSinglePetRepository())
    var isPetSaved = false

    func setMockData() {
        var singlePetData: AdoptPet
        if shouldPass {
        singlePetData =  AdoptPet(count: 1, page: [Page(age: "Adult", center: Center(city: "JHB", id: 1,
                                      lat: 12.89, lon: 13.67, name: "Center JHB", services: "none",
                                      state: "SA", zipcode: "2456"), color: "Ginger", desc: "Pretty cat",
                                      petId: 1, name: "Baba", animalImage: "link", sex: "Female",
                                      animalSpeciesBreed: SpeciesBreed(petBreedName: "Tabby", speciesID: 1,
                                                         petSpecies: "Cat", petYouthName: "Kitten"))])
        singlePetViewmodel.setSinglePetObject(petObject: singlePetData)
        singlePetViewmodel.setSelectedPetIndex(indexPet: 0)
        } else {
        }
    }

    override func isPetSaved(petName: String) -> Bool {
        if shouldPass {
            isPetSaved = true
        } else {
            isPetSaved = false
        }

        return isPetSaved
    }

}
