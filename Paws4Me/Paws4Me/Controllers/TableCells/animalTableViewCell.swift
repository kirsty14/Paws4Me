//
//  AnimalTableViewCell.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//

import Foundation
import UIKit

class AnimalTableViewCell: UITableViewCell {
    // MARK: - IBOulets
    @IBOutlet weak private var imagePetView: UIImageView!
    @IBOutlet weak private var petNameLabel: UILabel!
    // MARK: - Var/Lets
    var index = 0
    var pet: AdoptPet! {
        didSet {
            updateUI()
        }
    }
    // MARK: - Functions
    func updateUI() {
        guard let pageImage = pet?.page?[index].animalImage else {
            return
        }
        let imageReturnedViewPet = UIImage.displayImgFromUrl(url: pageImage, petImageView: self.imagePetView)
        UIImage.addCornerRadiusToImage(petImageView: imageReturnedViewPet)
        guard let name = pet.page?[index].name else { return }
        petNameLabel.text = name
    }
}
