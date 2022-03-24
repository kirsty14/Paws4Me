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
    private let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private lazy var singlePetViewModel = SinglePetViewModel()
    private var singlePet: AdoptPet?
    private var indexSinglePet: Int = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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

    func updateUI() {
        setPlaceholderImage()
        singlePetViewModel.setSelectedPetIndex(indexPet: indexSinglePet)
        guard let singelPetObject = singlePet else { return }
        singlePetViewModel.setSinglePetObject(petObject: singelPetObject)
        petNameLabel.text = singlePetViewModel.getSinglePetName()
        petBreedNameLabel.text = singlePetViewModel.getSinglePetBreed()
        petGenderLabel.text = singlePetViewModel.getSinglePetGender()
        guard let imgPet = singlePetViewModel.getSinglePetImage() else { return }
        petImageView.loadImageFromURL(imageURL: imgPet)
        view.addSubview(petImageView)
    }

    func setPlaceholderImage() {
        guard let petType = singlePet?.page?[indexSinglePet].animalSpeciesBreed?.petSpecies else { return }
        let petTypeSelected = SpeciesName(rawValue: petType)

        switch petTypeSelected {
        case .kitten, .cat:
            petImageView.image = UIImage(named: "placeholderCat.png")
        case .puppy, .dog:
            petImageView.image = UIImage(named: "placeholderDog.png")
        case .none:
            petImageView.image = UIImage(named: "placeholderAll.png")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPetViewController {
            guard let petName = singlePetViewModel.getSinglePetName() else { return }
            guard let petImage = singlePetViewModel.getSinglePetImage() else { return }
            destination.setNamePet(name: petName)
            destination.setImagePet(image: petImage)
        }
    }

    func isPetSaved(petName: String) {
        do {
            guard let pets = try viewContext?.fetch(Pet.fetchRequest()) else { return }

            for savedPet in pets where savedPet.petName == petName {
                saveSinglePetButton.isEnabled  = false
                return
            }
        } catch {
            displayAlert(alertTitle: "Unable to retreive all your saved pets",
                         alertMessage: "There was a problem retrieving",
                         alertActionTitle: "Try again" ,
                         alertDelegate: self, alertTriggered: .fatalLocalDatabaseAlert)
        }
    }
}
