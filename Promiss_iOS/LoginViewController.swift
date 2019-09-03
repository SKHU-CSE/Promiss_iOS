//
//  login_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
   @IBAction func clickSignUpButton(_ sender: Any) {
    guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as? SignupViewController
        else {
            return
        }
    self.present(signUpViewController, animated: true)
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
    }
    
}
