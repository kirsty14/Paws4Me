//
//  FavouriteTableViewCell.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/18.
//

import Foundation
import UIKit

class FavouriteTableViewCell: UITableViewCell {
    // MARK: - IBOulets
    @IBOutlet weak var favouitePetImageView: UIImageView!
    @IBOutlet weak var favouritePetNameLabel: UILabel!

    // MARK: - Vars/Lets
    var namePet: String! {
        didSet {
            updatePetnameUI()
        }
    }

    var imagePet: String! {
        didSet {
            updatePetImageUI()
        }
    }

    // MARK: - Functions
    func updatePetImageUI() {
        favouitePetImageView.loadImageFromURL(imageURL: imagePet)
            self.favouitePetImageView.layer.cornerRadius = 10
        favouritePetNameLabel.text = namePet
    }

    func updatePetnameUI() {
        favouritePetNameLabel.text = namePet
    }
}
