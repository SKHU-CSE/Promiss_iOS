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
        
        setupLayout()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func clickSignUpButton(_ sender: Any) {
        goToSignUp()
    }
    
    @IBAction func clickLoginButton(_ sender: Any) {
        guard let id = idTextField.text, let pw = pwTextField.text else {
            return
        }
        
        LoginService.shared.login(id, pw) { loginResult in
            switch loginResult.result {
            case 1000:  //fail
                self.showLoginFailAlert()
            case 2000:  //success
                guard let data = loginResult.data else {return}
                self.saveUserInfo(id: data.user_name, pw: data.user_pw, appointment: data.appointment_id)
                self.dismiss(animated: true, completion: nil)
            default:
                return
            }
        }
    }
}

// MARK: - 기능들
extension LoginViewController {
    private func goToSignUp() {
        guard let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as? SignupViewController else { return }
        self.present(signUpViewController, animated: true)
    }
    
    private func saveUserInfo(id: String, pw: String, appointment: Int){
        UserDefaults.standard.set(id, forKey: "id")
        UserDefaults.standard.set(pw, forKey: "pw")
        UserDefaults.standard.set(appointment, forKey: "appointment")
    }
    
    private func showLoginFailAlert() {
        let alert = UIAlertController(title: "로그인 실패", message: "아이디와 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
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
