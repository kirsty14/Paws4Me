//
//  HomePageTest.swift
//  Paws4MeTests
//
//  Created by Kirsty-Lee Walker on 2022/04/14.
//

import XCTest
@testable import Paws4Me

class HomePageTest: XCTestCase {

    private var homeViewModel: HomeViewModel!

    override func setUp() {
        homeViewModel = HomeViewModel()
    }

    func testCountHomeImage_ReturnEqual() {
        let homeViewControllerArray = setUpHomeViewController()
        XCTAssertEqual(homeViewControllerArray.count, homeViewModel.homeItemCount())
    }

    func testCountHomeImage_ReturnNotEqual() {
        _ = setUpHomeViewController()
        XCTAssertNotEqual(homeViewModel.homeItemCount(), 4)
    }

    func testHomeImageAtIndex_ReturnsEqual() {
        _ = setUpHomeImagess()
        XCTAssertEqual(homeViewModel.homePageImages(index: 0), "AllPetImage")
    }

    func testHomeImageAtIndex_ReturnsNotEqual() {
        _ = setUpHomeImagess()
        XCTAssertNotEqual(homeViewModel.homePageImages(index: 0), "FavouritesImage")
    }

    func testHomeTitleAtIndex_ReturnsEqual() {
        _ = setUpHomeTitle()
        XCTAssertEqual(homeViewModel.homePageTitle(index: 0), "All pets")
    }

    func testHomeTitleAtIndex_ReturnsNotEqual() {
        _ = setUpHomeTitle()
        XCTAssertNotEqual(homeViewModel.homePageTitle(index: 0), "Favourites")
    }

    func testHomeViewControllerAtIndex_ReturnsEqual() {
        _ = setUpHomeViewController()
        XCTAssertEqual(homeViewModel.homeViewControllerId(index: 0), "AllPetDetailViewController")
    }

    func testHomeViewControllerAtIndex_ReturnsNotEqual() {
        _ = setUpHomeViewController()
        XCTAssertNotEqual(homeViewModel.homeViewControllerId(index: 0), "LocalPetViewController")
    }

}

private func setUpHomeImagess() -> [String] {
    return ["AllPetImage", "FavouritesImage", "AdoptionProgressImage"]
}

private func setUpHomeTitle() -> [String] {
    return ["All pets", "Favourites", "Adoption Progress"]
}

private func setUpHomeViewController() -> [String] {
   return ["AllPetDetailViewController", "LocalPetViewController",
           "applicationForm"]
}
