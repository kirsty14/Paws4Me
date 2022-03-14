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
    // MARK: - IBOulets
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!

    // MARK: - Vars/Lets
    private var isLoggedIn = false
    private let bottomLine = CALayer()
    private let bottomLine2 = CALayer()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.addCornerRadius()
        registerButton.addCornerRadius()
        registerButton.changeBorderLook()
        addUnderline(usernameTextField, passwordTextField, bottomLine: bottomLine, bottomLine2: bottomLine2)
    }

    // MARK: - IBActions
    @IBAction private func signInButtonTapped (_ sender: UIButton!) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        isLoggedIn = isValidCredentials(username: username, password: password)
        var errorMessage = ""
        if isLoggedIn {
            performSegue(withIdentifier: "signInViewController", sender: self)
        } else if !isLoggedIn {
            errorMessage = "Incorrect Username or Password"
            addErrorBorderBoth(usernameTextField, passwordTextField, bottomLine: bottomLine, bottomLine2: bottomLine2) }
        displayErrorAlert(alertTitle: "Invalid credentials.",
                          alertMessage: errorMessage,
                          alertActionTitle: "Try again" ,
                          alertDelegate: self)
    }

    // MARK: - Functions
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
