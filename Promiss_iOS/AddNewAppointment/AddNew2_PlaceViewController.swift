//
//  AddNew2_PlaceViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap

class AddNew2_PlaceViewController: UIViewController {

    @IBOutlet weak var naverMapView: NMFNaverMapView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var detailAddressTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
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

extension AddNew2_PlaceViewController {
    func setupViewDesign() {
        addressView.setAsWhiteBorderView()
        detailAddressTextView.setWhiteBorder()
        nextButton.setAsYellowButton()
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
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew3") else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension UITextView {
    func setWhiteBorder() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
    }
}
