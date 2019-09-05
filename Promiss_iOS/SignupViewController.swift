//
//  signup_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
 
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button_custom()
        // Do any additional setup after loading the view.
    }
    @IBAction func clickSignUpButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func button_custom(){
        signUpButton.layer.cornerRadius = 6
    }
}
