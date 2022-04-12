//
//  HomeCollectionViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/12.
//

import Foundation
import UIKit

class HomeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Var/Lets
    let viewControllerIdentifiers: [String] = ["AllPetDetailViewController", "LocalPetViewController",
                                               "applicationForm"]
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllerIdentifiers.count
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
        cell.setCellItems(index: indexPath.row)
        return cell
    }
}
