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

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak private var nameTextfield: UITextField!
    @IBOutlet weak private var surnameTextfield: UITextField!
    @IBOutlet weak private var emailTextfield: UITextField!
    @IBOutlet weak private var passwordTextfield: UITextField!
    @IBOutlet weak private var cellphoneTextfield: UITextField!
    @IBOutlet weak private var addressTextfield: UITextField!

    // MARK: - Var/Lets
    private lazy var signUpViewModel = SignUpViewModel(delegate: self,
                                                       signUpRepository: SignUpRepository())

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.changeBorderLook()
        signInButton.addCornerRadius()
        registerButton.addCornerRadius()
    }

    // MARK: - IBAction
    @IBAction private func registerButtonTapped(_ sender: UIButton) {
        var isValidDetailsCredentials = false
        guard let name = nameTextfield.text,
              let surname = surnameTextfield.text,
              let cellphone = cellphoneTextfield.text,
              let email = emailTextfield.text,
              let password = passwordTextfield.text,
              let address = addressTextfield.text else { return }

        isValidDetailsCredentials = signUpViewModel.isUserDetailsValid(name: name,
                                                                       surname: surname,
                                                                       phone: cellphone,
                                                                       address: address)

        if isValidDetailsCredentials {
            signUpViewModel.signUpUser(email: email,
                                       password: password)
        }
    }

    @IBAction func signInButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signinViewController", sender: self)
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func successRouting() {
        self.performSegue(withIdentifier: "signinViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SignInViewController {
            destination.setUserCredentials(email: signUpViewModel.email,
                                           password: signUpViewModel.password)
        }
    }

    func addUserData() {
        guard let name = nameTextfield.text,
              let surname = surnameTextfield.text,
              let cellphone = cellphoneTextfield.text,
              let address = addressTextfield.text else { return }

        signUpViewModel.addUserToFirebase(name: name,
                                          surname: surname,
                                          cellphone: cellphone,
                                          address: address)
    }

    func showError(errorMessage: String) {
        displayAlert(alertTitle: "Sign Up Error",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self,
                     alertTriggered: .errorAlert)
    }
}
