//
//  UIColorExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/09.
//

import Foundation
import UIKit

extension UIColor {
    static var primaryAppColor: UIColor {
        return UIColor(named: "primaryAppColor")!
    }
    static var primaryAppError: UIColor {
        return UIColor(named: "primaryErrorColor")!
    }
    static var secondaryAppColor: UIColor {
        return UIColor(named: "secondaryAppColor")!
    }

    static var tertiaryAppColor: UIColor {
        return UIColor(named: "tertiaryAppColor")!
    }

    static var primaryAppDeleteColor: UIColor {
        return UIColor(named: "primaryAppDelete")!
    }

    static var primaryTitleColor: UIColor {
        return UIColor(named: "primaryTitleColor")!
    }

    static var myAppSection: UIColor {
        return UIColor.systemGray5
    }

    static var myAppHome1: UIColor {
        return UIColor(named: "AllPetColor")!
    }

    static var myAppHome2: UIColor {
        return UIColor(named: "favouritesPetColor")!
    }

    static var myAppHome3: UIColor {
        return UIColor(named: "adoptPetColor")!
    }
}
