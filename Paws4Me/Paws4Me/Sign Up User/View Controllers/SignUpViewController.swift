//
//  SignUpViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/04/19.
//

import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController {

    // MARK: - IBOulets
    @IBOutlet weak private var registerButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var surnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var cellphoneTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!

    // MARK: - Var/Lets
    private lazy var signUpViewModel = SignUpViewModel(delegate: self, signUpRepository: SignUpRepository())

    // MARK: - Life cycler
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
           signUpViewModel.signUpUser(email: email, password: password)
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func successRouting() {
        self.performSegue(withIdentifier: "AllPetDetailViewController", sender: self)
    }

    func showError(errorMessage: String) {
        displayAlert(alertTitle: "Sign Up Error",
                     alertMessage: errorMessage,
                     alertActionTitle: "Try again" ,
                     alertDelegate: self, alertTriggered: .errorAlert)
    }
}
