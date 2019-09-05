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
        
        setupTitleView()
    }
    
    @IBAction func clickProfileButton(_ sender: Any) {
        showProfileAlert()
    }
}

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
    
    func showProfileAlert() {
        let profileAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "로그아웃", style: .default) { _ in
            self.logout()
        }
        let changePwAction = UIAlertAction(title: "비밀번호 변경", style: .default) { _ in
            self.goToChangePassword()
        }
        let unsubscribeAction = UIAlertAction(title: "회원 탈퇴", style: .destructive) { _ in
            self.goToUnsubscribe()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        profileAlert.addAction(logoutAction)
        profileAlert.addAction(changePwAction)
        profileAlert.addAction(unsubscribeAction)
        profileAlert.addAction(cancelAction)
        
        present(profileAlert, animated: true)
    }
    
    func logout() { }
    func goToChangePassword() { }
    func goToUnsubscribe() { }
}
