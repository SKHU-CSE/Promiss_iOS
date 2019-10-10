//
//  login_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var promissLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        pwTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupCustomButton()
        setupCustomTextfield()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func clickSignUpButton(_ sender: Any) {
        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as? SignupViewController else { return }
        self.present(signUpViewController, animated: true)
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
        // 로그인
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController {
    
    func setupCustomButton(){
        loginButton.layer.cornerRadius = 6
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
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -200
        promissLabel.frame.origin.y = 260
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
        promissLabel.frame.origin.y = 60
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
