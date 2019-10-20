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
        guard let id = idTextField.text, let pw = pwTextField.text else {
            return
        }
        
        UserService.shared.signup(id, pw) { signupResult in
            switch signupResult.result {
            case 1000:  //fail
                self.showIdAlertLabel()
            case 2000:  //success
                self.showSuccessAlert()
            default:
                return
            }
        }
    }
    
    func showIdAlertLabel(){
        idAlertLabel.isHidden = false
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideIdAlertLabel), userInfo: nil, repeats: false)
    }
    
    @objc func hideIdAlertLabel() {
        idAlertLabel.isHidden = true
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "회원가입 성공", message: "회원가입이 완료되었습니다. 로그인 화면으로 돌아갑니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { action in
            self.dismiss(animated: true)
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
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
