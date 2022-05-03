//
//  SignUpViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/19.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {

    // MARK: - IBOulets
    @IBOutlet weak private var registerButton: UIButton!
    @IBOutlet weak private var clearAllButton: UIButton!
    @IBOutlet weak private var nameTextfield: UITextField!
    @IBOutlet weak private var surnameTextfield: UITextField!
    @IBOutlet weak private var emailTextfield: UITextField!
    @IBOutlet weak private var passwordTextfield: UITextField!
    @IBOutlet weak private var cellphoneTextfield: UITextField!
    @IBOutlet weak private var addressTextfield: UITextField!

    // MARK: - Var/Lets
    private lazy var signUpViewModel = SignUpViewModel(delegate: self, signUpRepository: SignUpRepository())

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpClearButton()
    }

    // MARK: - IBAction
    @IBAction private func registerButtonTapped(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
           signUpViewModel.signUpUser(email: email, password: password)
        }
    }
    @IBAction private func clearButtonTapped(_ sender: Any) {
        nameTextfield.text = ""
        surnameTextfield.text = ""
        emailTextfield.text = ""
        passwordTextfield.text = ""
        cellphoneTextfield.text = ""
        addressTextfield.text = ""
    }

    // MARK: - Functions
    func setUpClearButton() {
        clearAllButton.addCornerRadius()
        clearAllButton.changeBorderLook()
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func successRouting() {
        self.performSegue(withIdentifier: "signinViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SignInViewController {
            destination.setUserCredentials(email: signUpViewModel.email, password: signUpViewModel.password)
        }
    }

    func showError(errorMessage: String) {
        displayAlert(alertTitle: "Sign Up Error",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}
