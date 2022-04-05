//
//  UITextfieldExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UITextField {
func addUnderline() {
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = UIColor.primaryAppColor.cgColor
    border.frame = CGRect(x: 0, y: self.frame.height * 0.8, width: self.frame.width, height: 2)
    border.borderWidth = width
    self.borderStyle = .none
    self.layer.addSublayer(border)

}

func addErrorBorderBoth() {
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor =  UIColor.primaryAppError.cgColor
    border.frame = CGRect(x: 0, y: self.frame.height * 0.8, width: self.frame.width, height: 2)
    border.borderWidth = width
    self.borderStyle = .none
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
}
}
