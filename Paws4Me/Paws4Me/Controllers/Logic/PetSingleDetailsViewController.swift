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
    private var singlePet: AdoptPet?
    private var indexSinglePet: Int = 0
    private var namePet = ""
    private var breedPet = ""
    private var genderPet = ""
    private var agePet = ""
    private var imgPet = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petImageView.image = UIImage(named: "placeholder.jpg")
        guard let namePet = singlePet?.page?[indexSinglePet].name else { return }
        setNamePet(name: namePet)
        petNameLabel.text = namePet
        guard let agePet = singlePet?.page?[indexSinglePet].age else { return }
        setAgePet(age: agePet)
        petAgeLabel.text = agePet
        guard let breedPet = singlePet?.page?[indexSinglePet].animalSpeciesBreed?.petBreedName else { return }
        setBreedPet(breed: breedPet)
        petBreedNameLabel.text = breedPet
        guard let genderPet = singlePet?.page?[indexSinglePet].sex else { return }
        setGenderPet(gender: genderPet)
        petGenderLabel.text = genderPet
        guard let imgPet = singlePet?.page?[indexSinglePet].animalImage else { return }
        setImagePet(image: imgPet)
        petImageView.loadImageFromURL(imageURL: imgPet)
        view.addSubview(petImageView)
    }

    // MARK: - IBAction
    @IBAction func saveTappedButton(_ sender: Any) {
        performSegue(withIdentifier: "LocalPetViewController", sender: self)
    }

    // MARK: - Functions
    func setSelectedPetIndex(indexPet: Int) {
        self.indexSinglePet = indexPet
    }

    func setSinglePetObject(petObject: AdoptPet) {
        self.singlePet = petObject
    }

    func setNamePet(name: String) {
        self.namePet = name
    }

    func setBreedPet(breed: String) {
        self.breedPet = breed
    }

    func setGenderPet(gender: String) {
        self.genderPet = gender
    }

    func setAgePet(age: String) {
        self.agePet = age
    }

    func setImagePet(image: String) {
        self.imgPet = image
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPetViewController {
            destination.setNamePet(name: namePet)
            destination.setImagePet(image: imgPet)
        }
    }
}
