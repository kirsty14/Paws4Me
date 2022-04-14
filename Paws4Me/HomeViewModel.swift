//
//  homeViewModel.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/14.
//

import Foundation

class HomeViewModel {

    // MARK: - Var/Lets
    private let homeImages: [String] = ["AllPetImage", "FavouritesImage", "AdoptionProgressImage"]
    private let homeTitle: [String] = ["All pets", "Favourites", "Adoption Progress"]
    private let viewControllerIdentifiers: [String] = ["AllPetDetailViewController", "LocalPetViewController",
                                                       "applicationForm"]

    // MARK: - Functions
    func homePageImages(index: Int) -> String {
        return homeImages[index]
    }

    func homePageTitle(index: Int) -> String {
        return homeTitle[index]
    }

    func homeViewControllerId(index: Int) -> String {
        return viewControllerIdentifiers[index]
    }

    func homeItemCount() -> Int {
        return viewControllerIdentifiers.count
    }
}