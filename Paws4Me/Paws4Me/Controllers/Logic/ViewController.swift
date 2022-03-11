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
       private var searchBarController = UISearchBar()
       private var filteredPetObject: AdoptPet?
       private var adoptPetObject: AdoptPet?
       private var isSingleSearch = false
       private var isFilterSearch = true
       private var indexSinglePet: Int?
       private var selectedGender: String = ""
       private var petType = ""

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
    @IBAction private func btnCatTapped(_ sender: UIButton) {
           getPetTypeFromButton(sender)
           sender.changePetIconsColor()
           searchPetType(type: petType)
       }
       @IBAction private func btnKittenTapped(_ sender: UIButton) {
           getPetTypeFromButton(sender)
           sender.changePetIconsColor()
           searchPetType(type: petType)
       }
       @IBAction private func btnDogTapped(_ sender: UIButton) {
           getPetTypeFromButton(sender)
           sender.changePetIconsColor()
           searchPetType(type: petType)
       }
       @IBAction private func btnPuppyTapped(_ sender: UIButton) {
           getPetTypeFromButton(sender)
           sender.changePetIconsColor()
           searchPetType(type: petType)
       }

    // MARK: - Functions
    func getPetTypeFromButton(_ sender: UIButton) {
        petType = sender.titleLabel?.text ?? ""
    }

    // MARK: - Receive data from API
    func getAdoption() {
        let urlString = Constants.adoptURL
        if let request = URL(string: urlString) {
        URLSession.shared.makeRequest(url: request, model: AdoptPet.self) { [weak self] result in
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
           cell.backgroundColor = UIColor(named: "primaryTan")
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "PetSingleDetailsViewController", sender: self)
       }

       func getIndexPetSelected() -> Int {
           var indexRow = 0
           if !isSingleSearch || !isFilterSearch {
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

               setIndexForSpecificPetName(searchText: searchText, petObject: petObject )

               if filteredPetObject == nil {
                   filteredPetObject = adoptPetObject
               }
           }
           self.petTable.reloadData()
       }

       func setIndexForSpecificPetName (searchText: String, petObject: AdoptPet) {
           indexSinglePet =  petObject.page?.firstIndex(
            where: { $0.name?.lowercased().starts(with: searchText) ??  false })
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
           let petTypeSelected = SpeciesName(rawValue: type)

           switch petTypeSelected {
           case .kitten, .puppy:
               petAge = "young"
           case .cat, .dog:
               petAge = "adult"
           case .none:
               petAge = "adult"
           }
           return petAge
       }

       func searchPet(type: String, gender: String, petAge: String) {
           guard adoptPetObject != nil else {
               return
           }
           let petTypeLowercase = petType.lowercased()
           let isGenderValid = selectedGender != ""
           let isPetTypeValid = petType != ""
           if isPetTypeValid && isGenderValid {
               filterWithAgeTypeGender(type: petTypeLowercase, gender: selectedGender, petAge: petAge)
           } else if isGenderValid {
               filterOnlyWithGender()
           } else if isPetTypeValid {
               filterOnlyWithAgeAndType(type: petTypeLowercase, petAge: petAge)
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

           if filteredPetObject == nil {
               filteredPetObject = adoptPetObject
           } else {
               isFilterSearch = true
           }
       }

       func filterOnlyWithAgeAndType(type: String, petAge: String) {
           guard let petObject = adoptPetObject else {
               return
           }
           filteredPetObject?.page = petObject.page?.filter {
               $0.age?.lowercased() == petAge &&
               $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()}

           if filteredPetObject == nil {
               filteredPetObject = adoptPetObject
           } else {
               isFilterSearch = true
           }
       }

       func filterWithAgeTypeGender(type: String, gender: String, petAge: String) {
           guard let petObject = adoptPetObject else {
               return
           }
           filteredPetObject?.page = petObject.page?.filter {
               $0.age?.lowercased() == petAge &&
               $0.animalSpeciesBreed?.petSpecies?.lowercased()  == type.lowercased()
               && $0.sex?.lowercased() == gender}

           if filteredPetObject == nil {
               filteredPetObject = adoptPetObject
           } else {
               isFilterSearch = true
           }
       }
   }
