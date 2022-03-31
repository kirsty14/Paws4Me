//
//  LocalPetNameViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/10.
//

import UIKit

class LocalPetViewController: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak private var petNameTableView: UITableView!

    // MARK: - Vars/Lets
    private lazy var petLocalDatabaseViewModel = PetLocaldatabaseViewModel(repository: SavedPetDataRepository(),
                                                                           delegate: self)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        petLocalDatabaseViewModel.fetchPetDataResults()
        guard let petName =  petLocalDatabaseViewModel.nameSinglePet,
              let petImage =  petLocalDatabaseViewModel.imageSinglePet else { return }
        petLocalDatabaseViewModel.savePetInLocalDatabase(name: petName, image: petImage)
    }

    // MARK: - Functions
    func setSavedPetData(name: String?, image: String?) {
        guard let petName = name,
              let petimage = image else { return }
        petLocalDatabaseViewModel.set(petName: petName)
        petLocalDatabaseViewModel.set(imagePet: petimage)
    }

    private func setupTableView() {
        petNameTableView.dataSource = self
        petNameTableView.delegate = self
        title = "Saved Pets"
    }
}

// MARK: - UITableViewDataSource
extension LocalPetViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petLocalDatabaseViewModel.petSavedCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pet =  petLocalDatabaseViewModel.savedPet(at: indexPath.row) else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritePetCell",
                                                       for: indexPath) as? FavouriteTableViewCell
        else { return UITableViewCell() }

        let namePet = petLocalDatabaseViewModel.petNameSaved(pet: pet)
        let imagePet = petLocalDatabaseViewModel.petImageSaved(pet: pet)
        cell.updateUI(namePet: namePet, imagePet: imagePet)
        cell.setNeedsLayout()
        return cell
    }

    // MARK: - Delete
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal,
                                              title: "Delete",
                                              handler: { (_: UIContextualAction, _: UIView, success: (Bool) -> Void) in
            self.showDeleteWarning(for: indexPath)
            success(true)
        })

        deleteAction.backgroundColor = UIColor.myAppPurple
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func showDeleteWarning(for indexPath: IndexPath) {
        guard let petToRemove = petLocalDatabaseViewModel.savedPet(at: indexPath.row),
              let petDeleteName = petToRemove.petName else { return }
        presentAlertDeleteWarning(title: "Delete \(petDeleteName)",
                                  message: "Are you sure you want to delete \(petDeleteName)",
                                  options: "Cancel", "Delete") { [self] (optionPressed) in
            switch optionPressed {
            case "Cancel":
                break
            case "Delete":
                petLocalDatabaseViewModel.deletePetLocaldatabase(petToRemove: petToRemove)
                let isSucessDeleted = petLocalDatabaseViewModel.isPetSucessDeleted

                if isSucessDeleted {
                    petLocalDatabaseViewModel.fetchPetDataResults()
                } else {
                    showError(errorTitle: "Unable to delete \(petDeleteName)?",
                                              errorMessage: "There was a problem deleting \(petDeleteName)",
                                              action: .deletePetsError)
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
