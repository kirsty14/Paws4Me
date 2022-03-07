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
    var namePet = ""
    var breedPet = ""
    var genderPet = ""
    var agePet = ""
    var imgPet = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        petName.text = namePet
        petAge.text = agePet
        petBreedName.text = breedPet
        petGender.text = genderPet
        self.petImageView = UIImage.displayImgFromUrl(url: imgPet, petImageView: self.petImageView)
            view.addSubview(petImageView)
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
    public static func displayImgFromUrl(url: String, petImageView: UIImageView)
    -> UIImageView {
        guard let url = URL(string: url) else { return UIImageView() }
        UIImage.loadFrom(url: url) {image in
            petImageView.layer.cornerRadius = 10
            petImageView.image = image
    }
        return petImageView
}
}
