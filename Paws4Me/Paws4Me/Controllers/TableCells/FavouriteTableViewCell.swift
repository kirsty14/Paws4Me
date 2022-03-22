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

    // MARK: - Functions
    func updateUI(namePet: String, imagePet: String) {
        favouitePetImageView.loadImageFromURL(imageURL: imagePet)
        self.favouitePetImageView.layer.cornerRadius = 10
        favouritePetNameLabel.text = namePet
    }
}
