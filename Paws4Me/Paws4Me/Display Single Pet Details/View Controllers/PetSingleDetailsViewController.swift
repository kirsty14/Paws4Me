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
    @IBOutlet weak private var saveSinglePetButton: UIButton!

    // MARK: - Vars/Lets
    private lazy var singlePetViewModel = SinglePetViewModel(repository: SinglePetRepository())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholderImage()
        updateUI()
        isPetSaved()
    }

    // MARK: - IBAction
    @IBAction func saveTappedButton(_ sender: Any) {
        performSegue(withIdentifier: "LocalPetViewController", sender: self)
    }

    // MARK: - Placeholder image Function
    private func setPlaceholderImage() {
        guard let singlePetIndex = singlePetViewModel.singlePetIndex(),
              let singlePetObject = singlePetViewModel.singlePetObject(),
              let petType = singlePetObject.page?[singlePetIndex].animalSpeciesBreed?.petSpecies,
              let petTypeSelected = SpeciesName(rawValue: petType) else { return }

        switch petTypeSelected {
        case .kitten, .cat:
            petImageView.image = UIImage(named: "placeholderCat.png")
        case .puppy, .dog:
            petImageView.image = UIImage(named: "placeholderDog.png")
        }
    }

    // MARK: - UpdateUI function
    private func updateUI() {
        guard let singlePetIndex = singlePetViewModel.singlePetIndex(),
              let singlePetObject = singlePetViewModel.singlePetObject(),
              let imgPet = singlePetViewModel.singlePetImage else { return }

        singlePetViewModel.setSelectedPetIndex(indexPet: singlePetIndex)
        singlePetViewModel.setSinglePetObject(petObject: singlePetObject)
        petNameLabel.text = singlePetViewModel.singlePetName
        petBreedNameLabel.text = singlePetViewModel.singlePetBreed
        petGenderLabel.text = singlePetViewModel.singlePetGender
        petImageView.loadImageFromURL(imageURL: imgPet)
        view.addSubview(petImageView)
    }

    // MARK: - Pass single pet data to viewmodel function
    func setSinglePetData(petObject: AdoptPet?, petSingleIndex: Int?) {
        guard let singlePetObject = petObject,
              let singlePetIndex = petSingleIndex else { return }

        singlePetViewModel.setSinglePetObject(petObject: singlePetObject)
        singlePetViewModel.setSelectedPetIndex(indexPet: singlePetIndex)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPetViewController {
            guard let petName = singlePetViewModel.singlePetName else { return }
            guard let petImage = singlePetViewModel.singlePetImage else { return }
            destination.setNamePet(name: petName)
            destination.setImagePet(image: petImage)
        }
    }

    // MARK: - check if pet is already saved function
    private func isPetSaved() {
        guard let petName = singlePetViewModel.singlePetName else { return }
        let isPetSaved = singlePetViewModel.isPetSaved(petName: petName)

        if isPetSaved {
            saveSinglePetButton.isEnabled  = false
        }
    }
}
