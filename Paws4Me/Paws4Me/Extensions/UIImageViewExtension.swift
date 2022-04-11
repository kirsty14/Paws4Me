//
//  UIImageExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//
import Foundation
import UIKit

extension UIImageView {
    func loadImageFromURL(imageURL: String) {
        let url = URL(string: imageURL)
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

    func setImageCornerRadius(radius: Int) {
        self.layer.cornerRadius = 50
    }
}
