//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var petTable: UITableView!
    var adoptPetObject: AdoptPet?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Adoption Animals"
        getAdoption()
        petTable.delegate=self
        petTable.dataSource=self
    }

    func getAdoption() {
        var request = URLRequest(url: URL(string: Constants.adoptURL)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.makeRequest(url: request as URLRequest, model: AdoptPet.self) { [weak self] result in
            switch result {
            case .success(let petData):
                self?.adoptPetObject = petData
                print(petData)
                self?.petTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

           if let pageCount = adoptPetObject?.page?.count {
               return pageCount
           } else {
             return 0
           }
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "petAdopt") else {
           return UITableViewCell()
        }
           if let pageItem = adoptPetObject?.page?[indexPath.item].name {
               cell.textLabel?.text = pageItem
               cell.textLabel?.widthAnchor.constraint(equalToConstant: 250).isActive = true
               cell.textLabel?.heightAnchor.constraint(equalToConstant: 100).isActive = true
               cell.textLabel?.textAlignment = .center
           }
        if let pagePetImage = adoptPetObject?.page?[indexPath.item].animalImage {
            guard let url = URL(string: pagePetImage) else {return UITableViewCell()}
            UIImage.loadFrom(url: url) { image in
                cell.imageView?.layer.cornerRadius = 10
                cell.imageView?.image = image
                cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
                cell.imageView?.clipsToBounds = true
                cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
                cell.imageView?.heightAnchor.constraint(equalToConstant: 100).isActive = true
                cell.imageView?.widthAnchor.constraint(equalToConstant: 100).isActive = true
                cell.setNeedsLayout()
            }
        }
       return cell
   }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPetSingleDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination=segue.destination as? PetSingleDetailsViewController {
            guard let pageItem = adoptPetObject?.page?[(petTable.indexPathForSelectedRow?.row)!] else {
                return
            }
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
}
extension UIViewController {
    func displayAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
