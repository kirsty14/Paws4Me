//
//  LocalPetNameViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/10.
//

import CoreData
import UIKit

class LocalPetViewController: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak private var petNameTableView: UITableView!
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Vars/Lets
    private var namePet = ""
    private var imagePet = ""
    private var pets: [Pet]? = []
    private lazy var petLocalDatabaseViewModel = PetLocaldatabaseViewModel(repository: SavedPetDataRepository(),
                                                                           delegate: self)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        petLocalDatabaseViewModel.fetchPetDataResults()
        petLocalDatabaseViewModel.savePetInLocalDatabase(name: namePet, image: imagePet)
    }

    // MARK: - Functions
    func setupTableView() {
        petNameTableView.dataSource = self
        petNameTableView.delegate = self
        title = "Saved Pets"
    }

    func setNamePet(name: String) {
        self.namePet = name
    }

    func setImagePet(image: String) {
        self.imagePet = image
    }
}

// MARK: - UITableViewDataSource
extension LocalPetViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petLocalDatabaseViewModel.petSavedCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pet =  petLocalDatabaseViewModel.savedPet(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritePetCell",
                                                       for: indexPath) as? FavouriteTableViewCell
        else { return UITableViewCell() }

        guard let namePet = petLocalDatabaseViewModel.petName(pet: pet) else { return UITableViewCell() }
        guard let imagePet = petLocalDatabaseViewModel.petImage(pet: pet) else { return UITableViewCell() }
        cell.updateUI(namePet: namePet, imagePet: imagePet)
        cell.setNeedsLayout()
        return cell
    }

    // MARK: - Delete saved pet
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal,
                                              title: "Delete",
                                              handler: { (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            DispatchQueue.main.async {
                self.showDeleteWarning(for: indexPath)
            }
            success(true)
        })
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = UIColor.myAppPurple
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func showDeleteWarning(for indexPath: IndexPath) {
        guard let petToRemove = petLocalDatabaseViewModel.savedPet(at: indexPath.row) else { return }
        presentAlertDeleteWarning(title: "Delete Pet",
                                  message: "Are you sure you want to delete this pet?",
                                  options: "Cancel", "Delete") { (optionPressed) in
            switch optionPressed {
            case "Cancel":
                break
            case "Delete":
                DispatchQueue.main.async {
                    self.context?.delete(petToRemove)

                    do {
                        try self.context?.save()
                    } catch {
                        self.showError(errorTitle: "Unable to save",
                                       errorMessage: "There was a problem saving", action: .savePetsError)
                    }

                    self.petLocalDatabaseViewModel.fetchPetDataResults()
                    self.petNameTableView.deleteRows(at: [indexPath], with: .fade)
                }
            default:
                break
            }
        }
    }
}

// MARK: - PetLocalDatabaseViewModel functions
extension LocalPetViewController: PetLocalDatabaseViewModelDelegate {
func reloadView() {
    petNameTableView.reloadData()
}

    func showError(errorTitle: String, errorMessage: String, action: LocalDatabaseError) {
    displayAlert(alertTitle: errorTitle,
                 alertMessage: errorMessage,
                 alertActionTitle: "Try again" ,
                 alertDelegate: self,
                 alertTriggered: .fatalLocalDatabaseAlert)
}
}
