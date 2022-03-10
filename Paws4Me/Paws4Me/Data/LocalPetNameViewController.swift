//
//  LocalPetNameViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/10.
//

import CoreData
import UIKit

class LocalPetViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var petNameTableView: UITableView!

    // MARK: - Vars/Lets
    var namePet = ""
    var pets: [NSManagedObject] = []

    // MARK: - Life cycle
    override func viewDidLoad() {
      super.viewDidLoad()
      title = "Saved Pets"
        petNameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pet")
      let nameToSave = namePet

      do {
        pets = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }

       save(name: nameToSave)
       petNameTableView.reloadData()
    }

    func save(name: String) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Pet", in: managedContext)!
      let pet = NSManagedObject(entity: entity, insertInto: managedContext)
        pet.setValue(name, forKeyPath: "petName")

      do {
        try managedContext.save()
        pets.append(pet)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
  }

  // MARK: - UITableViewDataSource
  extension LocalPetViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return pets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let pet = pets[indexPath.row]
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      cell.textLabel?.text = pet.value(forKeyPath: "petName") as? String
      return cell
    }
      func tableView(_ tableView: UITableView,
                     commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
          }

          let managedContext = appDelegate.persistentContainer.viewContext

        if editingStyle == .delete {
            managedContext.delete(pets[indexPath.row])
          do {
            try managedContext.save()
            tableView.reloadData()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
        }
      }
  }
