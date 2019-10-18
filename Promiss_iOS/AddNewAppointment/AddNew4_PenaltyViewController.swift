//
//  AddNew4_PenaltyViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew4_PenaltyViewController: UIViewController {

    @IBOutlet weak var plusMinButton: UIButton!
    @IBOutlet weak var minusMinButton: UIButton!
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var minNotificationLabel: UILabel!
    
    @IBOutlet weak var plusMoneyButton: UIButton!
    @IBOutlet weak var minusMoneyButton: UIButton!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var moneyNotificationLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
        setupTarget()
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickExitButton(_ sender: Any) {
        showExitAlert()
    }
    @IBAction func clickNextButton(_ sender: Any) {
        showNextViewController()
    }
    @IBAction func clickPlusMinButton(_ sender: Any) {
        plusMin()
    }
    @IBAction func clickMinusMinButton(_ sender: Any) {
        minusMin()
    }
    @IBAction func clickPlusMoneyButton(_ sender: Any) {
        plusMoney()
    }
    @IBAction func clicMinusMoneyButton(_ sender: Any) {
        minusMoney()
    }
}

extension AddNew4_PenaltyViewController {
    func setupViewDesign() {
        minTextField.setWhiteBorder()
        moneyTextField.setWhiteBorder()
        nextButton.setAsYellowButton()
        minNotificationLabel.alpha = 0
        moneyNotificationLabel.alpha = 0
    }
    
    func setupTarget() {
        minTextField.addTarget(self, action: #selector(minTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        moneyTextField.addTarget(self, action: #selector(moneyTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func showExitAlert() {
        let alert = UIAlertController(title: "약속만들기 취소", message: "약속 정보가 저장되지 않습니다.\n정말로 취소하시겠습니까?", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "계속 만들기", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "만들기 취소", style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func showNextViewController() {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew5") else { return }
        
        AppointmentInfo.shared.fineTime = Int(minTextField.text ?? "5")
        AppointmentInfo.shared.fineMoney = Int(moneyTextField.text ?? "100")
        
        print(AppointmentInfo.shared.name)
        
        print(AppointmentInfo.shared.address)
        print(AppointmentInfo.shared.detailAddress)
        print(AppointmentInfo.shared.latitude)
        print(AppointmentInfo.shared.longitude)
        
        print(AppointmentInfo.shared.dateString)
        print(AppointmentInfo.shared.timeString)
        
        print(AppointmentInfo.shared.fineTime)
        print(AppointmentInfo.shared.fineMoney)
        
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension AddNew4_PenaltyViewController {
    
    @objc func minTextFieldDidChange(_ textField: UITextField) {
        checkMinTextField()
    }
    @objc func moneyTextFieldDidChange(_ textField: UITextField) {
        checkMoneyTextField()
    }
    
    func plusMin() {
        guard let text = minTextField.text, let currentMin = Int(text) else {
            return
        }
        minTextField.text = String(currentMin + 1)
        checkMinTextField()
    }
    
    func minusMin() {
        guard let text = minTextField.text, let currentMin = Int(text) else {
            return
        }
        minTextField.text = String(currentMin - 1)
        checkMinTextField()
    }
    
    func plusMoney() {
        guard let text = moneyTextField.text, let currentMin = Int(text) else {
            return
        }
        moneyTextField.text = String(currentMin + 100)
        checkMoneyTextField()
    }
    
    func minusMoney() {
        guard let text = moneyTextField.text, let currentMin = Int(text) else {
            return
        }
        moneyTextField.text = String(currentMin - 100)
        checkMoneyTextField()
    }
    
    func checkMinTextField() {
        guard let text = minTextField.text, let currentMin = Int(text) else {
            minTextField.text = String(5)
            return
        }
        if currentMin <= 5 {
            minTextField.text = String(5)
            showMinNotification()
            return
        }
        if currentMin >= 60 {
            minTextField.text = String(60)
            showMinNotification()
            return
        }
    }
    
    func checkMoneyTextField() {
        guard let text = moneyTextField.text, let currentMin = Int(text) else {
            moneyTextField.text = String(100)
            return
        }
        if currentMin <= 100 {
            moneyTextField.text = String(100)
            showMoneyNotification()
            return
        }
        if currentMin >= 10000 {
            moneyTextField.text = String(10000)
            showMoneyNotification()
            return
        }
    }
    
    func showMinNotification() {
        self.minNotificationLabel.alpha = 1
        UIView.animate(withDuration: 3.0, animations: ({
            self.minNotificationLabel.alpha = 0
        }))
    }
    
    func showMoneyNotification() {
        self.moneyNotificationLabel.alpha = 1
        UIView.animate(withDuration: 3.0, animations: ({
            self.moneyNotificationLabel.alpha = 0
        }))
    }
}
