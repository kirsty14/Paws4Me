//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

class SignInViewController: UIViewController {
    // MARK: - IBOulets
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!

    // MARK: - Vars/Lets
    private var isLoggedIn = false
    private let bottomLine = CALayer()
    private let bottomLine2 = CALayer()
    private lazy var signInViewModel = SignInViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.addCornerRadius()
        registerButton.addCornerRadius()
        registerButton.changeBorderLook()
        usernameTextField.addUnderline()
        passwordTextField.addUnderline()
    }

    // MARK: - IBActions
    @IBAction private func signInButtonTapped (_ sender: UIButton!) {
        var errorMessage = ""
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        isLoggedIn = signInViewModel.isValidCredentials(username: username, password: password)

        if isLoggedIn {
            performSegue(withIdentifier: "signInViewController", sender: self)
        } else if !isLoggedIn {
            errorMessage = "Incorrect Username or Password"
            usernameTextField.addErrorBorderBoth()
            passwordTextField.addErrorBorderBoth()
        }
        displayAlert(alertTitle: "Invalid credentials.",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }

}