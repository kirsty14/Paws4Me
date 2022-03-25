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
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        isLoggedIn = signInViewModel.isValidCredentials(username: username, password: password)

        if isLoggedIn {
              successRouting()
        } else if !isLoggedIn {
           show(errorMessage: "Incorrect Username or Password")
        } else if username.isEmpty || password.isEmpty {
            show(errorMessage: "Please fill in your username and password")
        }
    }

}

// MARK: - SignInViewModelDelegate Delegate
extension SignInViewController: SignInViewModelDelegate {

    func successRouting() {
        performSegue(withIdentifier: "signInViewController", sender: self)
    }

    func show(errorMessage: String) {
        usernameTextField.addErrorBorderBoth()
        passwordTextField.addErrorBorderBoth()
        displayAlert(alertTitle: "Invalid Credentials",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}
