//
//  AnimalTableViewCell.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//

import Foundation
import UIKit

class AnimalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePetView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    
    var index = 0
    var pet: AdoptPet! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        guard let pageImage = pet?.page?[index].animalImage else {
            return
        }
        
        guard let url = URL(string: pageImage) else { return }

        UIImage.loadFrom(url: url) { [self] image in
            self.imagePetView.layer.cornerRadius = 10
            self.imagePetView.image = image
        }
        guard let name = pet.page?[index].name else { return }
        petNameLabel.text = name
    }
}
