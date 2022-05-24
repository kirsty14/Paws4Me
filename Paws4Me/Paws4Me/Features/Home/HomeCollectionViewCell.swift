//
//  HomeCollectionViewCell.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/12.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var homeImage: UIImageView!
    @IBOutlet weak private var homeLabel: UILabel!

    // MARK: - Vars/Lets
    private lazy var homeViewModel = HomeViewModel()
    let homeViewColors = [UIColor.myAppHome1, UIColor.myAppHome2,
                          UIColor.myAppHome3]

    // MARK: - Function
    func setCellItems(index: Int) {
        homeImage.image = UIImage(named: homeViewModel.homePageImages(index: index))
        homeLabel.text = homeViewModel.homePageTitle(index: index)
        cellView.backgroundColor = homeViewColors[index]
        cellView.layer.cornerRadius = 30
    }
}
