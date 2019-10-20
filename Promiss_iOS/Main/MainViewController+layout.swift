//
//  MainViewController+layout.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

extension MainViewController {
    func setupTitleView() {
        let colorTop = UIColor.white.cgColor
        let colorBottom = UIColor(white: 1, alpha: 0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.titleView.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        
        self.titleView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupMainInfo() {
        switch appointmentStatus{
        case .Progress:
            appointmentNameLabel.text = AppointmentInfo.shared.name
            createOrDetailButton.isHidden = true
            break
            
        case .Wait:
            appointmentNameLabel.text = AppointmentInfo.shared.name
            createOrDetailButton.isHidden = false
            createOrDetailButton.setTitle("상세보기", for: .normal)
            
        case .Done:
            appointmentNameLabel.text = "현재 약속이 없습니다."
            leftTimeLabel.text = ""
            createOrDetailButton.isHidden = false
            createOrDetailButton.setTitle("약속 만들기", for: .normal)
            return
        }
    }
    
    func setupInviteView() {
        inviteMessageView.layer.cornerRadius = 20
        inviteMessageView.alpha = 0
    }
}
