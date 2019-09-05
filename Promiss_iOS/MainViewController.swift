//
//  MainViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 04/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var leftTimeLabel: UILabel!
    
    @IBOutlet weak var createOrDetailButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
