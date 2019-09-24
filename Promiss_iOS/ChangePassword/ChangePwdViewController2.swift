//
//  ChangePwdViewController2.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class ChangePwdViewController2: UIViewController {

    @IBOutlet weak var newPwTextField: UITextField!
    @IBOutlet weak var checkNewPwTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTextfield()
        setupCustomButton()
    }

    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickExitButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func clickCheckButton(_ sender: Any) {
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "cpw3"){
            
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
}

extension ChangePwdViewController2 {
    
    func setupCustomButton(){
        checkButton.layer.cornerRadius = 6
    }
    
    func setupCustomTextfield(){
        newPwTextField.layer.borderColor = UIColor.white.cgColor
        newPwTextField.layer.borderWidth = 2
        newPwTextField.layer.cornerRadius = 6
        newPwTextField.textColor = UIColor.white
        
        checkNewPwTextField.layer.borderColor = UIColor.white.cgColor
        checkNewPwTextField.layer.borderWidth = 2
        checkNewPwTextField.layer.cornerRadius = 6
        checkNewPwTextField.textColor = UIColor.white
    }
}
