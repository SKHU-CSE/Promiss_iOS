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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
        setupCustomTextfield()
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
    
    func setupCustomTextfield(){
        idTextField.layer.borderColor = UIColor.white.cgColor
        idTextField.layer.borderWidth = 2
        idTextField.layer.cornerRadius = 6
        idTextField.textColor = UIColor.white
        pwTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.cornerRadius = 6
        pwTextField.textColor = UIColor.white
        checkPwTextField.layer.borderColor = UIColor.white.cgColor
        checkPwTextField.layer.borderWidth = 2
        checkPwTextField.layer.cornerRadius = 6
        checkPwTextField.textColor = UIColor.white
    }
}

