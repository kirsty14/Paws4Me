//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var petTable: UITableView!
    // Creates an pet object for users to reference the data
    var adoptPetObject:AdoptPet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Adoption Animals"
        // Calls the function that will execute get users api call
        getAdoption()
        
        petTable.delegate=self
        petTable.dataSource=self

    }
    
    // Function that will handle the logic for requesting the api call
    func getAdoption() {
        
        var request = URLRequest(url: URL(string: Constants.adoptURL)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
  
        // Asks the url session to make a call to our custom function
        URLSession.shared.makeRequest(url: request as URLRequest , model: AdoptPet.self) { [weak self] result in
            
            // Swift the state of the result
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

extension ViewController: UITableViewDelegate,UITableViewDataSource {

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
           }
        
        if let pagePetImage = adoptPetObject?.page?[indexPath.item].animalImage {
            let imageView = UIImageView()
            imageView.image = UIImage(named: pagePetImage)
            cell.imageView?.image = imageView.image
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
            
            destination.nameOfPet = pageItem.name!
            destination.ageOfPet =  pageItem.age!
            
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
