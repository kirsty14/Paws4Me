//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    // MARK: - IBOulets
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    @IBOutlet weak private var registerButton: UIButton!

    // MARK: - Vars/Lets
    private var isLoggedIn = false
    private let bottomLine = CALayer()
    private let bottomLine2 = CALayer()
    private lazy var signInViewModel = SignInViewModel(delegate: self,
                                                       signInRepository: SignInRepository())

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUpLogin()
    }

    override func viewDidAppear(_ animated: Bool) {
        if signInViewModel.email != "" && signInViewModel.password != "" {
            emailTextField.text = signInViewModel.email
            passwordTextField.text = signInViewModel.password
        }
    }

    // MARK: - IBActions
    @IBAction private func signInButtonTapped (_ sender: UIButton!) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        signInViewModel.loginUser(email: email,
                                  password: password)
    }

    @IBAction private func signUpButtonTapped(_ sender: UIButton!) {
        performSegue(withIdentifier: "signUpViewController",
                     sender: self)
    }

    // MARK: - Functions
    func setUpLogin() {
        signInButton.addCornerRadius()
        signInButton.changeBorderLook()
        registerButton.addCornerRadius()
        registerButton.changeBorderLook()
        emailTextField.setPadding()
        passwordTextField.setPadding()
        emailTextField.setBottomBorder(borderColor: UIColor.primaryAppColor)
        passwordTextField.setBottomBorder(borderColor: UIColor.primaryAppColor)
    }

    func setUserCredentials(email: String, password: String) {
        signInViewModel.set(userEmail: email,
                            userPassword: password)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return false }
        signInViewModel.loginUser(email: email,
                                  password: password)
        return true
    }
}

// MARK: - SignInViewModelDelegate Delegate
extension SignInViewController: SignInViewModelDelegate {

    func successRouting() {
        passwordTextField.text = ""
        emailTextField.text = ""
        performSegue(withIdentifier: "petAllViewController",
                     sender: self)
    }

    func showError(errorMessage: String) {
        emailTextField.setBottomBorder(borderColor: UIColor.primaryAppError)
        passwordTextField.setBottomBorder(borderColor: UIColor.primaryAppError)
        displayAlert(alertTitle: "Invalid Credentials",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self,
                     alertTriggered: .errorAlert)
    }
}
