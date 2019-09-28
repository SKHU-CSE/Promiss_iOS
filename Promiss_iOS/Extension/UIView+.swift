//
//  UIView+.swift
//  Promiss_iOS
//
//  Created by 임수현 on 22/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

extension UIView {
    func setAsWhiteBorderView() {
        self.layer.cornerRadius = 6
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
}
