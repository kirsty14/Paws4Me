//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOulets
    @IBOutlet weak private var usernameTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!

    // MARK: - Vars/Lets
    private var isLoggedIn = false
    private let bottomLine = CALayer()
    private let bottomLine2 = CALayer()
    private lazy var signInViewModel = SignInViewModel(delegate: self)

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setUpLogin()
    }

    // MARK: - IBActions
    @IBAction private func signInButtonTapped (_ sender: UIButton!) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        signInViewModel.loginUser(username: username, password: password)
    }

    // MARK: - Functions
    func setUpLogin() {
        signInButton.addCornerRadius()
        signInButton.changeBorderLook()
        registerButton.addCornerRadius()
        registerButton.changeBorderLook()
        usernameTextField.setPadding()
        passwordTextField.setPadding()
        usernameTextField.setBottomBorder(borderColor: UIColor.primaryAppColor)
        passwordTextField.setBottomBorder(borderColor: UIColor.primaryAppColor)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return false }
        signInViewModel.loginUser(username: username, password: password)
        return true
    }
}

// MARK: - SignInViewModelDelegate Delegate
extension SignInViewController: SignInViewModelDelegate {

    func successRouting() {
        performSegue(withIdentifier: "signInViewController", sender: self)
    }

    func showError(errorMessage: String) {
        usernameTextField.setBottomBorder(borderColor: UIColor.primaryAppError)
        passwordTextField.setBottomBorder(borderColor: UIColor.primaryAppError)
        displayAlert(alertTitle: "Invalid Credentials",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}
