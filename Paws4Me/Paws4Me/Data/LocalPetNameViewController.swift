//
//  LocalPetNameViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/10.
//

import CoreData
import UIKit

class LocalPetViewController: UIViewController, UITableViewDelegate, PetLocalDatabaseViewModelDelegate {

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
      // fetchSavedPets()
      savePets(name: namePet, image: imagePet)
    }

    // MARK: - Functions
    func setupTableView() {
        petNameTableView.dataSource = self
        petNameTableView.delegate = self
        title = "Saved Pets"
    }

    func fetchSavedPets() {
        do {
            self.pets = try context?.fetch(Pet.fetchRequest())
            DispatchQueue.main.async {
                self.petNameTableView.reloadData()
            }

        } catch _ as NSError {
            displayAlert(alertTitle: "Unable to retreive all your saved pets",
                         alertMessage: "There was a problem retrieving",
                         alertActionTitle: "Try again" ,
                         alertDelegate: self, alertTriggered: .fatalLocalDatabaseAlert)
        }
    }

    func savePets(name: String, image: String) {
        guard let petContext = self.context else { return }
        let petObject = Pet(context: petContext)
        petObject.petName = namePet
        petObject.petImage = imagePet

      do {
          guard let petContext = self.context else { return }
          try petContext.save()
          DispatchQueue.main.async {
              self.petNameTableView.reloadData()
          }
      } catch _ as NSError {
          displayAlert(alertTitle: "Unable to save \(namePet)",
                             alertMessage: "There was a problem saving",
                             alertActionTitle: "Try again" ,
                             alertDelegate: self,
                             alertTriggered: .fatalLocalDatabaseAlert)
      }

        self.fetchSavedPets()
    }

    // MARK: - Functions

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
         guard let countPet = pets?.count else { return 0 }
         return countPet
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let pet = pets?[indexPath.row]
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritePetCell",
                                                        for: indexPath) as? FavouriteTableViewCell else {
             return UITableViewCell()
         }
         let namePet = pet?.value(forKeyPath: "petName") as? String ?? ""
         let imagePet = pet?.value(forKeyPath: "petImage") as? String ?? ""
         cell.updateUI(namePet: namePet, imagePet: imagePet)
         cell.setNeedsLayout()
       return cell
     }
       func tableView(_ tableView: UITableView,
                      trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let deleteAction = UIContextualAction(style: .normal, title: "Delete",
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
           guard let petToRemove = self.pets?[indexPath.row] else { return }
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
                           self.displayAlert(alertTitle: "Unable to save",
                                              alertMessage: "There was a problem saving",
                                              alertActionTitle: "Try again" ,
                                              alertDelegate: self,
                                              alertTriggered: .fatalLocalDatabaseAlert)
                       }
                       self.fetchSavedPets()
                       self.petNameTableView.deleteRows(at: [indexPath], with: .fade)
                   }
               default:
                   break
               }
           }
       }

       func reloadView() {
           petNameTableView.reloadData()
       }

       func show(errorTitle: String, errorMessage: String) {
           displayAlert(alertTitle: errorTitle,
                        alertMessage: errorMessage,
                        alertActionTitle: "Try again" ,
                        alertDelegate: self, alertTriggered: .fatalLocalDatabaseAlert)
       }
   }
