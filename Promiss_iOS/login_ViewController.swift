//
//  login_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class login_ViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
        
        }
    @IBAction func clickSignUpButton(_ sender: Any) {
        guard let signupviewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "signup") as? signup_ViewController
            else {
                return
        }
        self.present(signupviewcontroller, animated: true)
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
