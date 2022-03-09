//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    // MARK: - IBOulets
    @IBOutlet weak private var petTable: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBAction func btnCatClick(_ sender: UIButton) {
           let type = sender.titleLabel?.text?.lowercased() ?? ""
           searchPetType(type: type)
       }
       @IBAction func btnKittenClick(_ sender: UIButton) {
           let type = sender.titleLabel?.text?.lowercased() ?? ""
           searchPetType(type: type)
       }
       @IBAction func btnDogClick(_ sender: UIButton) {
           let type = sender.titleLabel?.text?.lowercased() ?? ""
           searchPetType(type: type)
       }
       @IBAction func btnPuppyClick(_ sender: UIButton) {
           let type = sender.titleLabel?.text?.lowercased() ?? ""
           searchPetType(type: type)
       }
    // MARK: - Vars/Lets
       var searchBarController = UISearchBar()
       var filteredPetObject: AdoptPet?
       var adoptPetObject: AdoptPet?
    // MARK: - Life cycle
       override func viewDidLoad() {
           super.viewDidLoad()
           getAdoption()
           petTable.delegate = self
           petTable.dataSource = self
           self.title = "Adoptable Animals"
           setUpSearchbar()
       }
    // MARK: - Functions
    func getAdoption() {
        let urlString = Constants.adoptURL
        if let request = URL(string: urlString) {
        URLSession.shared.makeRequest(url: request as URL, model: AdoptPet.self) { [weak self] result in
            switch result {
            case .success(let petData):
                self?.adoptPetObject = petData
                self?.filteredPetObject = petData
                print(petData)
                self?.petTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        }
    }
}

   extension ViewController: UITableViewDelegate, UITableViewDataSource {
       func setUpSearchbar() {
           searchBarController = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.petTable.bounds.width, height: 65))
           searchBarController.showsScopeBar = true
           searchBarController.scopeButtonTitles = ["Male", "Female"]
           // print(searchBarController.scopeButtonTitles![searchBarController.selectedScopeButtonIndex])
           searchBarController.selectedScopeButtonIndex = 0
           searchBarController.delegate = self
           self.petTable.tableHeaderView = searchBarController
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if let pageCount = filteredPetObject?.page?.count {
               return pageCount
           } else {
               return 0
           }
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "petAdoptCell") as? AnimalTableViewCell else {
               return UITableViewCell()
           }
           let adoptablepet = filteredPetObject
           cell.index = indexPath.row
           cell.pet = adoptablepet
           cell.setNeedsLayout()
           let bgColorView = UIView()
           bgColorView.backgroundColor = UIColor(named: "primaryTan")
           cell.selectedBackgroundView = bgColorView
           return cell
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "PetSingleDetailsViewController", sender: self)
       }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? PetSingleDetailsViewController {
               guard let rowIndex = petTable.indexPathForSelectedRow?.row else { return }
               guard let pageItem = adoptPetObject?.page?[rowIndex] else { return }
               if let pagePetName = pageItem.name {
                   destination.namePet = pagePetName
               }
               if let pagePetAge = pageItem.age {
                   destination.agePet = pagePetAge
               }
               if let pageGender = pageItem.sex {
                   destination.genderPet = pageGender
               }
               if let pagePetImage = pageItem.animalImage {
                   destination.imgPet = pagePetImage
               }
               if let pagePetBreed = pageItem.animalSpeciesBreed?.petBreedName {
                   destination.breedPet = pagePetBreed
               }
           }
       }
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText == "" {
               filteredPetObject = adoptPetObject
           } else {
               guard let petObject = adoptPetObject else {
                   return
               }
               let searchText = searchText.lowercased()
               filteredPetObject?.page = petObject.page?.filter { $0.name?.lowercased().starts(with: searchText)
                   ??  false}
               print(filteredPetObject as Any)
               if filteredPetObject == nil {
                   filteredPetObject = adoptPetObject
               }
           }
           self.petTable.reloadData()
       }
       func searchPetType(type: String) {
           if type == "" {
               filteredPetObject = adoptPetObject
           } else {
               guard let petObject = adoptPetObject else {
                   return
               }
               if type == "kitten" || type == "puppy" {
                   filteredPetObject?.page = petObject.page?.filter {
                       $0.age?.lowercased() == "young"}
                   if filteredPetObject == nil {
                       filteredPetObject = adoptPetObject
                   }
               } else if type == "cat" || type == "dog" {
                       filteredPetObject?.page = petObject.page?.filter {
                           $0.age?.lowercased() == "adult" &&
                           $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased() }
                       if filteredPetObject == nil {
                           filteredPetObject = adoptPetObject
                       }
                   }
                   self.petTable.reloadData()
               }
           }
       }
