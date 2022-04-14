//
//  HomeCollectionViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/12.
//

import Foundation
import UIKit

class HomeCollectionViewController: UIViewController {

    // MARK: - Vars/Lets
    private lazy var homeViewModel = HomeViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    }

extension HomeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
// MARK: - Collectionview
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return homeViewModel.homeItemCount()
}

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let destination = storyboard?.instantiateViewController(withIdentifier:
                                                            homeViewModel.homeViewControllerId(index: indexPath.row))
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
