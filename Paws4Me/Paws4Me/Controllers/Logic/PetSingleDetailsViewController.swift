//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class PetSingleDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak private var petImageView: UIImageView!
    @IBOutlet weak private var petName: UILabel!
    @IBOutlet weak private var petAge: UILabel!
    @IBOutlet weak private var petGender: UILabel!
    @IBOutlet weak private var petBreedName: UILabel!

    // MARK: - Vars/Lets
    var singlePet: AdoptPet?
    var namePet = ""
    var breedPet = ""
    var genderPet = ""
    var agePet = ""
    var imgPet = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petName.text = namePet
        petAge.text = agePet
        petBreedName.text = breedPet
        petGender.text = genderPet
        self.petImageView = UIImage.displayImgFromUrl(url: imgPet, petImageView: self.petImageView)
        view.addSubview(petImageView)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}
