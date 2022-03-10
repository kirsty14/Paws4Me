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

    // MARK: - Vars/Lets
       var searchBarController = UISearchBar()
       var filteredPetObject: AdoptPet?
       var adoptPetObject: AdoptPet?
       var isSingleSearch = false
       var indexSinglePet: Int?
       var selectedGender: String = ""
       var petType = ""

    // MARK: - Life cycle
       override func viewDidLoad() {
           super.viewDidLoad()
           getAdoption()
           petTable.delegate = self
           petTable.dataSource = self
           self.title = "Adoptable Animals"
           setUpSearchbar()
       }

    // MARK: - IBActions
    @IBAction func btnCatTapped(_ sender: UIButton) {
           petType = sender.titleLabel?.text?.lowercased() ?? ""
           sender.layer.borderColor = UIColor.myAppPurple.cgColor
           sender.layer.borderWidth = 2
           searchPetType(type: petType)
       }
       @IBAction func btnKittenTapped(_ sender: UIButton) {
           petType = sender.titleLabel?.text?.lowercased() ?? ""
           sender.layer.borderColor = UIColor.myAppPurple.cgColor
           sender.layer.borderWidth = 2
           searchPetType(type: petType)
       }
       @IBAction func btnDogTapped(_ sender: UIButton) {
           petType = sender.titleLabel?.text?.lowercased() ?? ""
           sender.layer.borderColor = UIColor.myAppPurple.cgColor
           sender.layer.borderWidth = 2
           searchPetType(type: petType)
       }
       @IBAction func btnPuppyTapped(_ sender: UIButton) {
           petType = sender.titleLabel?.text?.lowercased() ?? ""
           sender.layer.borderColor = UIColor.myAppPurple.cgColor
           sender.layer.borderWidth = 2
           searchPetType(type: petType)
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
           searchBarController.selectedScopeButtonIndex = 0
           searchBarController.delegate = self
           self.petTable.tableHeaderView = searchBarController
       }

       // MARK: - Tableview
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
           let bgColorView = UIViewSetBackgroundColor()
           cell.selectedBackgroundView = bgColorView
           return cell
       }
       func UIViewSetBackgroundColor() -> UIView {
           let bgColorView = UIView()
           bgColorView.backgroundColor = UIColor(named: "primaryTan")
           return bgColorView
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "PetSingleDetailsViewController", sender: self)
       }
       func getIndexPetSelected() -> Int {
           var indexRow = 0
           if !isSingleSearch {
               guard let rowIndex = petTable.indexPathForSelectedRow?.row else { return 0 }
               indexRow = rowIndex
           } else {
               guard let indexPet = indexSinglePet else { return 0 }
               indexRow = indexPet
           }
           return indexRow
       }

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? PetSingleDetailsViewController {
               let indexRow = getIndexPetSelected()
               guard let pageItem = adoptPetObject?.page?[indexRow] else { return }
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

       // MARK: - Search
       func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
           if selectedScope == 0 {
               selectedGender = "male"
           } else if selectedScope == 1 {
               selectedGender = "female"
           }
           searchPetType(type: petType)
       }

       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText == "" {
               filteredPetObject = adoptPetObject
           } else {
               isSingleSearch = true
               guard let petObject = adoptPetObject else {
                   return
               }
               let searchText = searchText.lowercased()
               filteredPetObject?.page = petObject.page?.filter { $0.name?.lowercased().starts(with: searchText)
                   ??  false}
               indexSinglePet =  petObject.page?.firstIndex(
                where: { $0.name?.lowercased().starts(with: searchText) ??  false })
               print(filteredPetObject as Any)
               if filteredPetObject == nil {
                   filteredPetObject = adoptPetObject
               }
           }
           self.petTable.reloadData()
       }

       func searchPetType(type: String) {
           if type == "" && selectedGender == ""{
               filteredPetObject = adoptPetObject
           } else {
               guard adoptPetObject != nil else { return }
               let petAge = getAgeFromType(type: type)
               searchPet(type: type, gender: selectedGender, petAge: petAge)
               if filteredPetObject == nil {
                   filteredPetObject = adoptPetObject
               }
                   self.petTable.reloadData()
               }
           }

       func getAgeFromType(type: String) -> String {
           var petAge = ""
           if type == "kitten" || type == "puppy" {
               petAge = "young"
           } else if type == "cat" || type == "dog" {
               petAge = "adult"
           }
           return petAge
       }

       func searchPet(type: String, gender: String, petAge: String) {
           guard adoptPetObject != nil else {
               return
           }
           let isGenderValid = selectedGender != "" ? true : false
           let isPetTypeValid = petType != "" ? true : false
           if isPetTypeValid && isGenderValid {
               filterWithAgeTypeGender(type: petType, gender: selectedGender, petAge: petAge)
           } else if isGenderValid {
               filterOnlyWithGender()
           } else if isPetTypeValid {
               filterOnlyWithAgeAndType(type: petType, petAge: petAge)
           } else {
               filteredPetObject = adoptPetObject
           }

       }

       // MARK: - Filter
       func filterOnlyWithGender() {
           guard let petObject = adoptPetObject else {
               return
           }
           filteredPetObject?.page = petObject.page?.filter {
               $0.sex?.lowercased() == selectedGender}
       }

       func filterOnlyWithAgeAndType(type: String, petAge: String) {
           guard let petObject = adoptPetObject else {
               return
           }
           filteredPetObject?.page = petObject.page?.filter {
               $0.age?.lowercased() == petAge &&
               $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()}
       }

       func filterWithAgeTypeGender(type: String, gender: String, petAge: String) {
           guard let petObject = adoptPetObject else {
               return
           }
           filteredPetObject?.page = petObject.page?.filter {
               $0.age?.lowercased() == petAge &&
               $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()
               && $0.sex?.lowercased() == gender}
       }
   }
