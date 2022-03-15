//
//  UIErrorAlertExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/15.
//

import Foundation
import UIKit

extension UIViewController {
    func displayErrorAlert(alertTitle: String,
                           alertMessage: String,
                           alertActionTitle: String,
                           alertDelegate: UIViewController) {
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: UIAlertAction.Style.default, handler: nil))
        alertDelegate.present(alert, animated: true, completion: nil)
    }
}
