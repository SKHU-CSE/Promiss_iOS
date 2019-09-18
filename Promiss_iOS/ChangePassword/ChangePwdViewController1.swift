//
//  ChangePasswordViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 06/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class ChangePwdViewController1: UIViewController {

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
        setupCustomTextfield()
    }
}

extension ChangePwdViewController1 {
    
    func setupCustomButton(){
        checkButton.layer.cornerRadius = 6
    }
    
    func setupCustomTextfield(){
        pwTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.cornerRadius = 6
        pwTextField.textColor = UIColor.white
    }
}
