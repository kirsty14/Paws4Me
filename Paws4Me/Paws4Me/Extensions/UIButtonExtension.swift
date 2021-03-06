//
//  UIButtonExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UIButton {
    func addCornerRadius() {
        self.layer.cornerRadius = 10
    }
    func changeBorderLook() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryAppColor.cgColor
    }
    func changePetIconsBorderColor() {
        self.layer.borderColor = UIColor.primaryAppColor.cgColor
        self.layer.borderWidth = 2
    }

    func clearPetIconBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
