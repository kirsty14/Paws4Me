//
//  UITextfieldExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UITextField {

    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setBottomBorder(borderColor: UIColor) {
        self.layer.shadowColor = borderColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

    func addFormErrorBorder() {
        self.layer.borderColor = UIColor.primaryAppError.cgColor
        self.layer.borderWidth = 1
    }

    func clearFormErrorBorder() {
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
