//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

protocol Validation {
    func isValidCredentialsUsername(username: String) -> Bool
    func isValidCredentialsPassword(password: String) -> Bool
}

let bottomLine = CALayer()
let bottomLine2 = CALayer()

class SignInViewController: UIViewController, Validation {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    var bLoggedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornerRadius(btnSignIn)
        addCornerRadius(btnRegister)
        changeBorderLook(btnRegister)
        addUnderline(txtUsername, txtPassword, bottomLine: bottomLine, bottomLine2: bottomLine2)
    }
    @IBAction private func btnSignInClick(_ sender: UIButton!) {
        guard let username = txtUsername.text else { return }
        guard let password = txtPassword.text else { return }
        let bValidUsername = isValidCredentialsUsername(username: username)
        let bValidPassword = isValidCredentialsPassword(password: password)
        var errorMessage = ""
    breakIf:
        if bValidUsername && bValidPassword {
            performSegue(withIdentifier: "signInViewController", sender: self)
        } else if !bValidUsername && !bValidPassword {
            errorMessage = "Incorrect Username and Password"
            addErrorBorderBoth(txtUsername, txtPassword)
            break breakIf
        } else if !bValidUsername {
            errorMessage = "Incorrect Username"
            addErrorBorderSingle(txtUsername, txtPassword, nameTextField: "Username")
            break breakIf
        } else if !bValidPassword {
            errorMessage = "Incorrect Password"
            addErrorBorderSingle(txtPassword, txtPassword, nameTextField: "Password")
            break breakIf
        }
        displayErrorAlert(alertTitle: "Invalid credentials.",
                          alertMessage: errorMessage,
                          alertActionTitle: "Try again" ,
                          alertDelegate: self)
    }
    func isValidCredentialsUsername(username: String) -> Bool {
        if username == "Admin"{
            return true
        } else {
            return false
        }
    }
    func isValidCredentialsPassword(password: String) -> Bool {
        if password == "TestPass123" {
            return true
        } else {
            return false
        }
    }
}

func resetBorderSingle(_ textField1: UITextField, bottomLine: CALayer) {
    bottomLine.backgroundColor = UIColor(named: "primaryPurple")?.cgColor
    bottomLine.frame = CGRect(x: 0, y: textField1.frame.height * 1.2, width: textField1.frame.width, height: 2)
}

func addErrorBorderSingle (_ textField1: UITextField, _ textField2: UITextField, nameTextField: String) {
    if nameTextField == "Username" {
        bottomLine.backgroundColor = UIColor(named: "primaryError")?.cgColor
    } else {
        resetBorderSingle(textField1, bottomLine: bottomLine)
    }
    textField1.borderStyle = .none
    textField1.layer.addSublayer(bottomLine2)
    if nameTextField == "Password" {
        bottomLine2.backgroundColor = UIColor(named: "primaryError")?.cgColor
    } else {
        resetBorderSingle(textField1, bottomLine: bottomLine2)
    }
    textField2.borderStyle = .none
    textField2.layer.addSublayer(bottomLine2)
}

func addErrorBorderBoth (_ textField1: UITextField, _ textField2: UITextField) {
    bottomLine.frame = CGRect(x: 0, y: textField1.frame.height * 1.2, width: textField1.frame.width, height: 2)
    bottomLine2.frame = CGRect(x: 0, y: textField2.frame.height * 1.2, width: textField2.frame.width, height: 2)
    bottomLine.backgroundColor = (UIColor.red).cgColor
    bottomLine2.backgroundColor = UIColor(named: "primaryError")?.cgColor
    textField1.borderStyle = .none
    textField2.borderStyle = .none
    textField1.layer.addSublayer(bottomLine)
    textField2.layer.addSublayer(bottomLine2)
}

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

extension UIViewController {
    func addCornerRadius (_ button: UIButton) {
        button.layer.cornerRadius = 10
    }
    func changeBorderLook (_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(named: "primaryPurple")?.cgColor
    }
    func addUnderline(_ textField1: UITextField, _ textField2: UITextField, bottomLine: CALayer, bottomLine2: CALayer) {
        bottomLine.frame = CGRect(x: 0, y: textField1.frame.height * 0.8, width: textField1.frame.width, height: 2)
        bottomLine2.frame = CGRect(x: 0, y: textField2.frame.height * 0.8, width: textField2.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor(named: "primaryPurple")?.cgColor
        bottomLine2.backgroundColor = UIColor(named: "primaryPurple")?.cgColor
        textField1.borderStyle = .none
        textField2.borderStyle = .none
        textField1.layer.addSublayer(bottomLine)
        textField2.layer.addSublayer(bottomLine2)
    }
}
