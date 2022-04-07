//
//  UIAlertErrorExtension.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/03/15.
//
import Foundation
import UIKit

enum TypeError {
    case informationAlert
    case errorAlert
    case confirmationAlert
    case fatalLocalDatabaseAlert
}

extension UIViewController {

    func displayAlert(alertTitle: String,
                      alertMessage: String,
                      alertActionTitle: String,
                      alertDelegate: UIViewController, alertTriggered: TypeError) {
        switch alertTriggered {
        case .informationAlert:
            let alertInformation = setUpBasicAlertStructure(alertTitle: alertTitle, alertMessage: alertMessage)
            alertInformation.addAction(UIAlertAction(title: alertActionTitle,
                                               style: UIAlertAction.Style.default, handler: nil))
            alertDelegate.present(alertInformation, animated: true, completion: nil)
        case .errorAlert:
            let alertError = setUpBasicAlertStructure(alertTitle: alertTitle, alertMessage: alertMessage)
            alertError.addAction(UIAlertAction(title: alertActionTitle,
                                               style: UIAlertAction.Style.default, handler: nil))
            alertDelegate.present(alertError, animated: true, completion: nil)
        case .confirmationAlert:
            let alertConfirm = setUpBasicAlertStructure(alertTitle: alertTitle, alertMessage: alertMessage)
            let okActionButton = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            let cancelActionButton = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            }
            alertConfirm.addAction(okActionButton)
            alertConfirm.addAction(cancelActionButton)
            present(alertConfirm, animated: true, completion: nil)
        case .fatalLocalDatabaseAlert:
            let alertLocalDatabaseError = setUpBasicAlertStructure(alertTitle: alertTitle, alertMessage: alertMessage)
            alertLocalDatabaseError.addAction(UIAlertAction(title: alertActionTitle,
                                               style: UIAlertAction.Style.default, handler: nil))
            alertDelegate.present(alertLocalDatabaseError, animated: true, completion: nil)
        }

    }

    func setUpBasicAlertStructure(alertTitle: String, alertMessage: String ) -> UIAlertController {
        let basicAlert = UIAlertController(title: alertTitle,
                                           message: alertMessage,
                                           preferredStyle: UIAlertController.Style.alert)
        return basicAlert
    }

    func presentAlertWarning(title: String, message: String, options: String...,
                             completion: @escaping (String) -> Void) {
          let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
          for (index, option) in options.enumerated() {
              alertController.addAction(UIAlertAction.init(title: option,
                                                           style: .default, handler: { _ in
                  completion(options[index])
              }))
          }
          self.present(alertController, animated: true, completion: nil)
      }

}
