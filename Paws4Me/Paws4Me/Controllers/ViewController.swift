//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var petTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredPetObject: AdoptPet?
    var adoptPetObject: AdoptPet?
    override func viewDidLoad() {
        super.viewDidLoad()
        getAdoption()
        petTable.delegate = self
        petTable.dataSource = self
        searchBar.delegate = self
        self.title = "Adoptable Animals"
    }

    func getAdoption() {
        guard let url = URL(string: Constants.adoptURL) else { fatalError("Missing URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.makeRequest(url: request as URLRequest, model: AdoptPet.self) { [weak self] result in
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {

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
       return cell
   }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPetSingleDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PetSingleDetailsViewController {
            guard let rowIndex = petTable.indexPathForSelectedRow?.row else {return}
            guard let pageItem = adoptPetObject?.page?[rowIndex] else {return}
            if let pagePetName = pageItem.name {
            destination.nameOfPet = pagePetName
            }
            if let pagePetAge = pageItem.age {
            destination.imagOfPet = pagePetAge
            }
            if let pageGender = pageItem.sex {
            destination.genderOfPet = pageGender
            }
            if let pagePetImage = pageItem.animalImage {
            destination.imagOfPet = pagePetImage
            }
            if let pagePetBreed = pageItem.animalSpeciesBreed?.petBreedName {
            destination.breedOfPet = pagePetBreed
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
