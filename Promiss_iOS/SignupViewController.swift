//
//  signup_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
 
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkPwTextField: UITextField!
    
    @IBOutlet weak var idAlertLabel: UILabel!
    @IBOutlet weak var pwAlertLabel: UILabel!
    @IBOutlet weak var pwCheckAlertLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
        setupCustomTextfield(textFields: idTextField, pwTextField, checkPwTextField)
        setupAlertLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func clickCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func clickSignUpButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SignupViewController{
    
    func setupCustomButton(){
        signUpButton.layer.cornerRadius = 6
    }
    
    func setupCustomTextfield(textFields: UITextField...){
        for textField in textFields {
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.borderWidth = 2
            textField.layer.cornerRadius = 6
            textField.textColor = UIColor.white
        }
    }
    
    func setupAlertLabel(){
        idAlertLabel.isHidden = true
        pwAlertLabel.isHidden = true
        pwCheckAlertLabel.isHidden = true
    }
}

