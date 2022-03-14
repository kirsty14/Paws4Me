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
        self.layer.borderColor = UIColor.myAppPurple.cgColor
    }
    func changePetIconsColor() {
        self.layer.borderColor = UIColor.myAppPurple.cgColor
        self.layer.borderWidth = 2
    }
}
