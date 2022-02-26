//
//  SignInViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//
import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    var bLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSignIn.layer.cornerRadius = 10
        btnRegister.layer.borderWidth = 1.0
        btnRegister.layer.cornerRadius = 10
        btnRegister.layer.borderColor = UIColor.init(red: 55/255,green: 21/255,blue: 67/255,alpha: 1).cgColor
        
        let bottomLine = CALayer()
        
        let bottomLine2 = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: txtUsername.frame.height - 2, width: txtUsername.frame.width , height: 2)
        
        bottomLine2.frame = CGRect(x: 0, y: txtPassword.frame.height - 2, width: txtPassword.frame.width , height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 55/255,green: 21/255,blue: 67/255,alpha: 1).cgColor
        
        bottomLine2.backgroundColor = UIColor.init(red: 55/255,green: 21/255,blue: 67/255,alpha: 1).cgColor
        
        txtUsername.borderStyle = .none
        txtPassword.borderStyle = .none
        txtUsername.layer.addSublayer(bottomLine)
        txtPassword.layer.addSublayer(bottomLine2)
        
    }

    @IBAction private func btnSignInClick(_ sender: Any) {
        let username = txtUsername.text
        let password = txtPassword.text
        if username == "Admin" && password == "TestPass123" {
            bLoggedIn = true
        
                  /* let alert = UIAlertController(title: "Success",
                   message: "You have logged in successfully.", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)*/
            
            if bLoggedIn {
                let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
                let vc = (storyboard.instantiateViewController(withIdentifier: "launchID") as? UIViewController)!
                self.present(vc, animated: true, completion: nil)
            }
            }
            
        }
    }
