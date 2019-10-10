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
        if isInProgress {
            appointmentNameLabel.text = "현재 약속 이름 표시"
            leftTimeLabel.text = "남은시간 표시"
            createOrDetailButton.setTitle("상세보기", for: .normal)
        } else {
            appointmentNameLabel.text = "현재 약속이 없습니다."
            leftTimeLabel.text = ""
            createOrDetailButton.setTitle("약속 만들기", for: .normal)
        }
    }
}
