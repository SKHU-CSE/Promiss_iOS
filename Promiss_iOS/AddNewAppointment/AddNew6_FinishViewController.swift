//
//  AddNew6_FinishViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 19/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class AddNew6_FinishViewController: UIViewController {

    @IBOutlet weak var detailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewDesign()
    }
    
    @IBAction func clickExitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickDetailButton(_ sender: Any) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detail") else {return}
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
    
}

extension AddNew6_FinishViewController {
    func setupViewDesign() {
        detailButton.setAsYellowButton()
    }
}
