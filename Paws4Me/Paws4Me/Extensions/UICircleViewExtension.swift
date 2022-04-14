//
//  UICircleViewExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/01.
//

import Foundation
import UIKit

extension UIView {
    func makeCircle() {
        self.layer.cornerRadius =  self.bounds.height / 2
    }

    func addBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.tertiaryAppColor.cgColor
    }
}
