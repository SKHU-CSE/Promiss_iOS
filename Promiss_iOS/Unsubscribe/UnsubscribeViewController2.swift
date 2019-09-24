//
//  UnsubscribeViewController2.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 23/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class UnsubscribeViewController2: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
    }

    @IBAction func clickLoginButton(_ sender: Any) {
        guard let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController else { return }
        self.present(loginViewController, animated: true)
        
    }
    
    func setupCustomButton(){
        loginButton.layer.cornerRadius = 6
    }
}
