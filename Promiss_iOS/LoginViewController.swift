//
//  login_ViewController.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 02/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UITextFieldDelegate{
    
    
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
        buttonCustom()
        textFieldCustom()
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
    
    func buttonCustom(){
        loginButton.layer.cornerRadius = 6
    }
    
    func textFieldCustom(){
        idTextField.layer.borderColor = UIColor.white.cgColor
        idTextField.layer.borderWidth = 2
        idTextField.layer.cornerRadius = 6
        idTextField.textColor = UIColor.white
        pwTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.cornerRadius = 6
        pwTextField.textColor = UIColor.white
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -200
        promissLabel.frame.origin.y = 228
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
        promissLabel.frame.origin.y = 28
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
}
