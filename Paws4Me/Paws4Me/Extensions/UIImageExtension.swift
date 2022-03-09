//
//  UIImageExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

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
            petImageView.image = image
        }
        return petImageView
    }
    public static func addCornerRadiusToImage(petImageView: UIImageView) {
        petImageView.layer.cornerRadius = 10
    }
}
