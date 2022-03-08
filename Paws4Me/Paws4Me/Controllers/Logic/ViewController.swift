//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak private var petTable: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    private var filteredPetObject: AdoptPet?
    private var adoptPetObject: AdoptPet?
    override func viewDidLoad() {
        super.viewDidLoad()
        getAdoption()
        petTable.delegate = self
        petTable.dataSource = self
        self.title = "Adoptable Animals"
        setUpSearchbar()
    }
    func getAdoption() {
        let urlString = "https://raw.githubusercontent.com/kirsty14/Paws4Me/Api_BackupPlan/Paws4Me/Paws4Me/Utilities/JsonObjct.json"
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
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.petTable.bounds.width, height: 65))
        searchbar.showsScopeBar = true
        searchbar.scopeButtonTitles = ["Male", "Female"]
        searchbar.selectedScopeButtonIndex = 0
        searchbar.delegate = self
        self.petTable.tableHeaderView = searchbar
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
        bgColorView.backgroundColor = UIColor.init(named: "primaryTan")
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
        self.filteredPetObject = nil
        if searchText == "" {
            filteredPetObject = adoptPetObject
        } else {
            guard let petObject = adoptPetObject else {
                return
            }
            if  searchText.lowercased().contains("Female") {
                filteredPetObject = petObject
            }
        }
        self.petTable.reloadData()
    }
}
extension UIViewController {
    func displayAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
