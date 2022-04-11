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
    @IBOutlet weak private var petAgeLabel: UILabel!
    @IBOutlet weak private var petGenderLabel: UILabel!
    @IBOutlet weak private var petBreedNameLabel: UILabel!
    @IBOutlet weak private var saveSinglePetButton: UIButton!
    @IBOutlet weak private var adoptPetButton: UIButton!
    @IBOutlet weak private var petBreedView: UIView!
    @IBOutlet weak private var petSexView: UIView!
    @IBOutlet weak private var petAgeView: UIView!

    // MARK: - Vars/Lets
    private lazy var singlePetViewModel = SinglePetViewModel(repository: SinglePetRepository())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholderImage()
        self.title = singlePetViewModel.singlePetName
        petImageView.setImageCornerRadius(radius: 50)
        petBreedView.addBorder()
        petBreedView.setViewsRadius(radius: 20)
        petSexView.addBorder()
        petSexView.setViewsRadius(radius: 20)
        petAgeView.addBorder()
        petAgeView.setViewsRadius(radius: 20)
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        if singlePetViewModel.isPetSaved() {
            saveSinglePetButton.setTitle("Saved", for: .normal)
            saveSinglePetButton.isEnabled = !singlePetViewModel.isPetSaved()
        }
    }

    // MARK: - IBAction
    @IBAction func saveTappedButton(_ sender: Any) {
        showSaveConfirmation()
    }

    @IBAction func adoptPetTappedButton(_ sender: Any) {
        performSegue(withIdentifier: "AdoptFirstFormPageViewController", sender: self)
    }

    // MARK: - Fuctions
    private func setPlaceholderImage() {
        guard let singlePetIndex = singlePetViewModel.singlePetIndex else { return }
        let singlePetObject = singlePetViewModel.singlePetObject

        guard let petType = singlePetObject?.page?[singlePetIndex].animalSpeciesBreed?.petSpecies else { return }
        guard let petTypeSelected = SpeciesName(rawValue: petType) else { return }

        switch petTypeSelected {
        case .kitten, .cat:
            petImageView.image = UIImage(named: "placeholderCat.png")
        case .puppy, .dog:
            petImageView.image = UIImage(named: "placeholderDog.png")
        }
    }

    // MARK: - UpdateUI function
    private func updateUI() {
        guard let singlePetIndex = singlePetViewModel.singlePetIndex,
              let singlePetObject = singlePetViewModel.singlePetObject else { return }

        singlePetViewModel.setSelectedPetIndex(indexPet: singlePetIndex)
        singlePetViewModel.setSinglePetObject(petObject: singlePetObject)
        petBreedNameLabel.text = singlePetViewModel.singlePetBreed
        petGenderLabel.text = singlePetViewModel.singlePetGender
        petImageView.loadImageFromURL(imageURL: singlePetViewModel.singlePetImage)
    }

    func setSinglePetData(petObject: AdoptPet?, petSingleIndex: Int?) {
        guard let singlePetObject = petObject,
              let singlePetIndex = petSingleIndex else { return }

        singlePetViewModel.setSinglePetObject(petObject: singlePetObject)
        singlePetViewModel.setSelectedPetIndex(indexPet: singlePetIndex)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPetViewController {
            destination.setSavedPetData(name: singlePetViewModel.singlePetName,
                                        image: singlePetViewModel.singlePetImage)
        }
    }

    private func showSaveConfirmation() {
        let petSaveName = singlePetViewModel.singlePetName
        let isSavedPet = singlePetViewModel.isPetSaved()
        presentAlertWarning(title: "Save \(petSaveName)",
                                  message: "Are you sure you want to save \(petSaveName)",
                                  options: "No", "Yes") { [self] (optionPressed) in
            switch optionPressed {
            case "No":
                break
            case "Yes":
                saveSinglePetButton.isEnabled = !isSavedPet
                saveSinglePetButton.setTitle("Saved", for: .normal)
                performSegue(withIdentifier: "LocalPetViewController", sender: self)
            default:
                break
            }
    }
}
}
