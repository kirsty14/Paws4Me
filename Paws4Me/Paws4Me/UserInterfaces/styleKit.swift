//
//  styleKit.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/08.
//

import Foundation

import UIKit

extension UIButton {
    func addCornerRadius(_ button: UIButton) {
        button.layer.cornerRadius = 10
    }
    func changeBorderLook(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.init(named: "primaryPurple")?.cgColor
    }
}

func addUnderline(_ textField1: UITextField, _ textField2: UITextField, bottomLine: CALayer, bottomLine2: CALayer) {
    bottomLine.frame = CGRect(x: 0, y: textField1.frame.height * 0.8, width: textField1.frame.width, height: 2)
    bottomLine2.frame = CGRect(x: 0, y: textField2.frame.height * 0.8, width: textField2.frame.width, height: 2)
    bottomLine.backgroundColor =  UIColor.init(named: "primaryPurple")?.cgColor
    bottomLine2.backgroundColor =   UIColor.init(named: "primaryPurple")?.cgColor
    textField1.borderStyle = .none
    textField2.borderStyle = .none
    textField1.layer.addSublayer(bottomLine)
    textField2.layer.addSublayer(bottomLine2)
}
