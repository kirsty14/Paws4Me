//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

protocol Validation {
    func isValidCredentials(username: String, password: String) -> Bool
}

class SignInViewController: UIViewController, Validation {
    @IBOutlet weak private var txtUsername: UITextField!
    @IBOutlet weak private var txtPassword: UITextField!
    @IBOutlet weak private var btnSignIn: UIButton!
    @IBOutlet weak private var btnRegister: UIButton!
    var isLoggedIn = false
    let bottomLine = CALayer()
    let bottomLine2 = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.addCornerRadius(btnSignIn)
        btnSignIn.addCornerRadius(btnRegister)
        btnSignIn.changeBorderLook(btnRegister)
        addUnderline(txtUsername, txtPassword, bottomLine: bottomLine, bottomLine2: bottomLine2)
    }
    @IBAction private func btnSignInClick(_ sender: UIButton!) {
        guard let username = txtUsername.text else { return }
        guard let password = txtPassword.text else { return }
        isLoggedIn = isValidCredentials(username: username, password: password)
        var errorMessage = ""
        if isLoggedIn {
            performSegue(withIdentifier: "signInViewController", sender: self)
        } else if !isLoggedIn {
            errorMessage = "Incorrect Username or Password"
            addErrorBorderBoth(txtUsername, txtPassword, bottomLine: bottomLine, bottomLine2: bottomLine2) }
        displayErrorAlert(alertTitle: "Invalid credentials.",
                          alertMessage: errorMessage,
                          alertActionTitle: "Try again" ,
                          alertDelegate: self)
    }
    func isValidCredentials(username: String, password: String) -> Bool {
        if username == "Admin" && password == "TestPass123" {
            return true
        } else {
            return false
        }
    }
}

func addErrorBorderBoth(_ textField1: UITextField, _ textField2: UITextField,
                        bottomLine: CALayer, bottomLine2: CALayer) {
    bottomLine.backgroundColor = UIColor.myAppError.cgColor
    bottomLine2.backgroundColor = UIColor.myAppError.cgColor
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

extension SignInViewController {
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
}

extension UIButton {
    func addCornerRadius(_ button: UIButton) {
        button.layer.cornerRadius = 10
    }
    func changeBorderLook(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(named: "primaryPurple")?.cgColor
    }
}
