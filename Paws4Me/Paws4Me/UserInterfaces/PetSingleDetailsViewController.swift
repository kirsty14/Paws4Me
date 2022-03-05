//
//  AdoptPet.swift
//  Paws4Me
//
//  Created by Kirsty-lee Walker 20/02/2022
//

import UIKit

class PetSingleDetailsViewController: UIViewController {

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petGender: UILabel!
    @IBOutlet weak var petBreedName: UILabel!
    var singlePet: AdoptPet?
    var nameOfPet = ""
    var breedOfPet = ""
    var genderOfPet = ""
    var ageOfPet = ""
    var imagOfPet = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        petName.text=nameOfPet
        petAge.text=ageOfPet
        petBreedName.text=breedOfPet

        petGender.text=genderOfPet
        guard let url = URL(string: imagOfPet) else { return }

        UIImage.loadFrom(url: url) { [self] image in
            self.petImageView.layer.cornerRadius = 10
            self.petImageView.image = image
            self.petImageView.backgroundColor = UIColor(red: 55/255.0, green: 21/255.0, blue: 67/255.0, alpha: 1)
            view.addSubview(petImageView)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.navigationBar.isHidden = false
        }
}

extension UIImage {
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
