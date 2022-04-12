//
//  HomeCollectionViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/12.
//

import Foundation
import UIKit

class HomeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let homeImages: [String] = ["AllPetImage", "FavouritesImage", "AdoptionProgressImage"]
    let homeTitle: [String] = ["All pets", "Favourites", "Adoption Progress"]
    let viewControllerIdentifiers: [String] = ["AllPetDetailViewController", "LocalPetViewController",
                                               "applicationForm"]
    let homeViewColors = [UIColor(named: "AllPetColor"), UIColor(named: "favouritesPetColor"),
                          UIColor(named: "adoptPetColor")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeImages.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(withIdentifier:
                                                                viewControllerIdentifiers[indexPath.row])
        self.navigationController?.pushViewController(destination!, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                            for: indexPath) as? HomeCollectionViewCell
        else { return UICollectionViewCell() }

        cell.homeImage.image = UIImage(named: homeImages[indexPath.row])
        cell.homeLabel.text = homeTitle[indexPath.row]
        cell.cellView.backgroundColor = homeViewColors[indexPath.row]
        cell.cellView.layer.cornerRadius = 30
        return cell
    }
}
