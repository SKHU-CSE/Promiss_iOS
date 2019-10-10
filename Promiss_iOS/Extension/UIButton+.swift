//
//  UIButton+.swift
//  Promiss_iOS
//
//  Created by 임수현 on 22/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

extension UIButton {
    func setWhiteBorder() {
        self.setAsWhiteBorderView()
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setAsYellowButton() {
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.pmLemon
        self.setTitleColor(UIColor.pmDarkBlue, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 24)
    }
}
