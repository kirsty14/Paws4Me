//
//  UIButtonExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UIButton {
    func addCornerRadius(_ button: UIButton) {
        button.layer.cornerRadius = 10
    }
    func changeBorderLook(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.myAppPurple.cgColor
    }
    
}
