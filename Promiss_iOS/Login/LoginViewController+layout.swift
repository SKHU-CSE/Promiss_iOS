//
//  LoginViewController+layout.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    func setupLayout() {
        setupTextField()
        setupCustomButton()
        setupCustomTextField()
    }
    
    private func setupCustomButton(){
        loginButton.layer.cornerRadius = 6
    }
    
    private func setupCustomTextField(){
        idTextField.layer.borderColor = UIColor.white.cgColor
        idTextField.layer.borderWidth = 2
        idTextField.layer.cornerRadius = 6
        idTextField.textColor = UIColor.white
        idTextField.setPadding(left: 10, right: 10)
        
        pwTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.cornerRadius = 6
        pwTextField.textColor = UIColor.white
        pwTextField.setPadding(left: 10, right: 10)
    }
    
    private func setupTextField(){
        idTextField.delegate = self
        pwTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
