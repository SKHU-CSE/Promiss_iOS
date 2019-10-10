//
//  ChangePwdViewController3.swift
//  Promiss_iOS
//
//  Created by Anna Lee on 23/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class ChangePwdViewController3: UIViewController {

    @IBOutlet weak var checkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomButton()
    }
    
    @IBAction func clickCheckButton(_ sender: Any) {
        if let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login"){
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}

extension ChangePwdViewController3 {
    
    func setupCustomButton(){
        checkButton.layer.cornerRadius = 6
    }
}
