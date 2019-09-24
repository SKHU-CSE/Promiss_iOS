//
//  UnsubscribeViewController1.swift
//  Promiss_iOS
//
//  Created by 임수현 on 06/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class UnsubscribeViewController1: UIViewController {

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTextfield()
        setupCustomButton()
    }
    
    @IBAction func clickCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickButton(_ sender: Any) {
        showProfileAlert()
    }
    
}

extension UnsubscribeViewController1 {
    
    func setupCustomButton(){
        checkButton.layer.cornerRadius = 6
    }
    
    func setupCustomTextfield(){
        pwTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderWidth = 2
        pwTextField.layer.cornerRadius = 6
        pwTextField.textColor = UIColor.white
    }
    
    func showProfileAlert() {
        let alert = UIAlertController(title: "회원탈퇴", message: "정말로 탈퇴하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default){_ in
            self.confirm()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func confirm() {
        guard let unsubscribe = self.storyboard?.instantiateViewController(withIdentifier: "unsubscribe2") else {
            return
        }
        self.present(unsubscribe, animated: true, completion: nil)
    }
}


