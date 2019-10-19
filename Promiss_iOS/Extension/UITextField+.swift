//
//  UITextField+.swift
//  Promiss_iOS
//
//  Created by 임수현 on 22/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

extension UITextField {
    func setWhiteBorder() {
        self.setAsWhiteBorderView()
        self.textColor = UIColor.white
    }
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

extension UITextView {
    func setWhiteBorder() {
        self.setAsWhiteBorderView()
        self.textColor = UIColor.white
    }
}
