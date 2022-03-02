//
//  LaunchViewController.swift
//  Paws4Me
//
//  Created by Kirsty-Lee Walker on 2022/02/26.
//

import Foundation

import UIKit

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "LaunchID", bundle: nil)
        let goToSignIn = (storyboard.instantiateViewController(withIdentifier: "SignInID") as UIViewController)
        self.present(goToSignIn, animated: true, completion: nil)
        }
    }
