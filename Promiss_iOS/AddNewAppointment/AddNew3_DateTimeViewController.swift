//
//  AddNew3_DateTimeViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew3_DateTimeViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
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
}

extension AddNew3_DateTimeViewController {
    
    private func setView() {
        dateButton.setWhiteBorder()
        timeButton.setWhiteBorder()
        nextButton.setAsYellowButton()
    }
    
    private func setButtonDesign(buttons: UIButton...) {
        for btn in buttons {
            btn.layer.cornerRadius = 6
            btn.layer.borderWidth = 2
            btn.layer.borderColor = UIColor.white.cgColor
        }
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
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew4") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
