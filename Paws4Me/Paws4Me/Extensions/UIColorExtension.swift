//
//  UIColorExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UIColor {
    static var myAppPurple: UIColor {
        return UIColor(named: "primaryPurple") ?? UIColor.clear
    }
    static var myAppError: UIColor {
        return UIColor(named: "primaryError") ?? UIColor.clear
    }
    static var myAppTan: UIColor {
        return UIColor(named: "primaryTan") ?? UIColor.clear
    }
}
