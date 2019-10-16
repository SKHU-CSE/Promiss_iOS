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
    @IBOutlet weak var checkPwAlertLabel: UILabel!
    
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
        // 회원가입 통신
        // 성공 시 dismiss
        // 실패 시 idAlertLabel 띄우기
        self.dismiss(animated: true)
    }
}

extension SignupViewController{
    
    func setupCustomButton(){
        signUpButton.layer.cornerRadius = 6
        signUpButton.setEnableFalse()
    }
    
    func setupCustomTextfield(textFields: UITextField...){
        for textField in textFields {
            textField.setWhiteBorder()
            textField.setPadding(left: 10, right: 10)
            textField.addTarget(self, action: #selector(SignupViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    func setupAlertLabel(){
        idAlertLabel.isHidden = true
        pwAlertLabel.isHidden = false
        checkPwAlertLabel.isHidden = true
    }
}

extension SignupViewController {
    func isEnablePassword() -> Bool{
        guard let pwText = pwTextField.text else {return false}
        if pwText.count < 6 || pwText.count > 12 {
            return false
        }
        return true
    }
    
    func isSamePassword() -> Bool{
        guard let pwText = pwTextField.text, let checkText = checkPwTextField.text else {return false}
        
        if pwText == checkText {
            return true
        }
        return false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if isEnablePassword() {
            pwAlertLabel.isHidden = true
        } else {
            pwAlertLabel.isHidden = false
        }
        if isSamePassword() {
            checkPwAlertLabel.isHidden = true
        } else {
            checkPwAlertLabel.isHidden = false
        }
        
        if pwAlertLabel.isHidden && checkPwAlertLabel.isHidden && idTextField.text?.count != 0 {
            signUpButton.setEnableTrue()
        } else {
            signUpButton.setEnableFalse()
        }
    }
}

extension UIButton {
    func setEnableFalse() {
        self.setTitleColor(UIColor.lightGray, for: .normal)
        self.isEnabled = false
    }
    func setEnableTrue() {
        self.setTitleColor(UIColor.black, for: .normal)
        self.isEnabled = true
    }
}
