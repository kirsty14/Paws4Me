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
    @IBOutlet weak private var petNameLabel: UILabel!
    @IBOutlet weak private var petAgeLabel: UILabel!
    @IBOutlet weak private var petGenderLabel: UILabel!
    @IBOutlet weak private var petBreedNameLabel: UILabel!

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
        petNameLabel.text = namePet
        petAgeLabel.text = agePet
        petBreedNameLabel.text = breedPet
        petGenderLabel.text = genderPet
        petImageView.load(imageURL: imgPet)
        view.addSubview(petImageView)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - IBAction
    @IBAction func btnSaveTapped(_ sender: Any) {
        performSegue(withIdentifier: "LocalPetViewController", sender: self)
    }

    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPetViewController {
            destination.namePet = namePet
            destination.imagePet = imgPet
        }
    }
}
