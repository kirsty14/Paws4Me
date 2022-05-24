//
//  SinglePetTest.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/04/10.
//

import XCTest
@testable import Paws4Me
import CoreData

struct SavedPetObject {
    let ldbImagePet: String?
    var ldbNamePet: String?
}

class SinglePetTest: XCTestCase {

    private var singlePetViewModel: SinglePetViewModel!
    private var mockSinglePetRepository: MockSinglePetRepository!

    override func setUp() {
        mockSinglePetRepository = MockSinglePetRepository()
        singlePetViewModel = SinglePetViewModel(repository: mockSinglePetRepository)
    }

    // MARK: - Single pet
    func testSinglePetByName_ReturnsTrue() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetName, "Baba")
    }

    func testSinglePetByName_ReturnsFalse() {
        XCTAssertNotEqual(singlePetViewModel.singlePetName, "Baba")
    }

    func testSinglePetByAge_ReturnsTrue() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetAge, "Adult")
    }

    func testSinglePetByAge_ReturnsFalse() {
        XCTAssertNotEqual(singlePetViewModel.singlePetAge, "Adult")
    }

    func testSinglePetByGender_ReturnsTrue() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetGender, "Female")
    }

    func testSinglePetByGender_ReturnsFalse() {
        XCTAssertNotEqual(singlePetViewModel.singlePetGender, "Male")
    }

    func testSinglePetByBreed_ReturnsTrue() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetBreed, "Tabby")
    }

    func testSinglePetByBreed_ReturnsFalse() {
        XCTAssertNotEqual(singlePetViewModel.singlePetBreed, "Dog")
    }

    func testSinglePetByImage_ReturnsTrue() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetImage, "link")
    }

    func testSinglePetByImage_ReturnsFalse() {
        XCTAssertNotEqual(singlePetViewModel.singlePetImage, "link")
    }

    func testSinglePetIndex_ReturnsEqual() {
        setMockData(shouldPass: true)
        XCTAssertEqual(singlePetViewModel.singlePetIndex, 0)
    }

    func testSinglePetIndex_ReturnsNotEqual() {
        XCTAssertNotEqual(singlePetViewModel.singlePetIndex, 1)
    }

    func testMockDataIsNil() {
        setMockData(shouldPass: false)
        XCTAssertNil(singlePetViewModel.singlePetObject)
    }

    // MARK: - Save pet
    func testIsPetSaved_ReturnsTrue() {
        mockSinglePetRepository.petSaved = true
        mockSinglePetRepository.setPetSavedData()
        XCTAssertTrue(singlePetViewModel.isPetSaved())
    }

    func testIsPetSaved_ReturnsFalse() {
        mockSinglePetRepository.petSaved = false
        mockSinglePetRepository.setPetSavedData()
        XCTAssertFalse(singlePetViewModel.isPetSaved())
    }

    func setMockData(shouldPass: Bool) {
        var singlePetData: AdoptPet
        if shouldPass {
        singlePetData =  AdoptPet(count: 1, page: [Page(age: "Adult", center: Center(city: "JHB", id: 1,
                                  lat: 12.89, lon: 13.67, name: "Center JHB", services: "none",
                                  state: "SA", zipcode: "2456"), color: "Ginger", desc: "Pretty cat",
                                  petId: 1, name: "Baba", animalImage: "link", sex: "Female",
                                  animalSpeciesBreed: SpeciesBreed(petBreedName: "Tabby", speciesID: 1,
                                  petSpecies: "Cat", petYouthName: "Kitten"))])
            singlePetViewModel.setSinglePetObject(petObject: singlePetData)
            singlePetViewModel.setSelectedPetIndex(indexPet: 0)
        } else {
        }

}
}

class MockSinglePetRepository: SinglePetRepository {
    var shouldBeSaved = true
    var arraySavedPets: [SavedPetObject] = []
    var petSaved = false

    func setPetSavedData() {
        if petSaved {
        arraySavedPets.append(SavedPetObject(ldbImagePet: "link", ldbNamePet: "Baba"))
        }
    }

    override func isPetSaved(petName: String) -> Bool {

        for savedPet in arraySavedPets where savedPet.ldbNamePet == "Baba" {
            petSaved = true
        }
        return petSaved
    }
}
