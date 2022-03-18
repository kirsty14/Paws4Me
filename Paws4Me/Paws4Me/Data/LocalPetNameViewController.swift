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
    @IBOutlet weak var petNameTableView: UITableView!
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Vars/Lets
    var namePet = ""
    var imagePet = ""
    var pets: [Pet]? = []

    // MARK: - Life cycle
    override func viewDidLoad() {
      super.viewDidLoad()
      petNameTableView.dataSource = self
      petNameTableView.delegate = self
      title = "Saved Pets"
      fetchSavedPets()
      savePets(name: namePet, image: imagePet)
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
        let petObject = Pet(context: self.context!)
        petObject.petName = namePet
        petObject.petImage = imagePet

      do {
          try self.context!.save()
          DispatchQueue.main.async {
              self.petNameTableView.reloadData()
          }
      } catch _ as NSError {
          displayAlert(alertTitle: "Unable to save \(namePet)",
                             alertMessage: "There was a problem saving",
                             alertActionTitle: "Try again" ,
                       alertDelegate: self, alertTriggered: .fatalLocalDatabaseAlert)
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
         guard let countPet = pets?.count else {return 0}
         return countPet
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let pet = pets?[indexPath.row]
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritePetCell",
                                                        for: indexPath) as? FavouriteTableViewCell else {
             return UITableViewCell()
         }
         cell.namePet = pet?.value(forKeyPath: "petName") as? String ?? ""
         cell.imagePet = pet?.value(forKeyPath: "petImage") as? String ?? ""
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
           let alert = UIAlertController(title: "Delete Pet",
                                         message: "Are you sure you want to delete this pet?", preferredStyle: .alert)

           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

           let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
               DispatchQueue.main.async {
                   let petToRemove = self.pets?[indexPath.row]
                   guard let removePet = petToRemove else { return }
                   self.context?.delete(removePet)

                   do {
                       try self.context?.save()
                   } catch let error as NSError {
                       print("Could not save. \(error), \(error.userInfo)")
                   }
                   self.fetchSavedPets()
                   self.petNameTableView.deleteRows(at: [indexPath], with: .fade)
               }
           }

           alert.addAction(cancelAction)
           alert.addAction(deleteAction)
           present(alert, animated: true, completion: nil)
       }
   }
