//
//  UITextfieldExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

func addUnderline(_ textField1: UITextField, _ textField2: UITextField, bottomLine: CALayer, bottomLine2: CALayer) {
    bottomLine.frame = CGRect(x: 0, y: textField1.frame.height * 0.8, width: textField1.frame.width, height: 2)
    bottomLine2.frame = CGRect(x: 0, y: textField2.frame.height * 0.8, width: textField2.frame.width, height: 2)
    bottomLine.backgroundColor = UIColor.myAppPurple.cgColor
    bottomLine2.backgroundColor =  UIColor.myAppPurple.cgColor
    textField1.borderStyle = .none
    textField2.borderStyle = .none
    textField1.layer.addSublayer(bottomLine)
    textField2.layer.addSublayer(bottomLine2)
}

func addErrorBorderBoth(_ textField1: UITextField, _ textField2: UITextField,
                        bottomLine: CALayer, bottomLine2: CALayer) {
    bottomLine.backgroundColor = UIColor.myAppError.cgColor
    bottomLine2.backgroundColor = UIColor.myAppError.cgColor
    textField1.layer.addSublayer(bottomLine)
    textField2.layer.addSublayer(bottomLine2)
}
