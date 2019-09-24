//
//  MainViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 04/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap

class MainViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var myLocationMarker: NMFMarker = NMFMarker()
    var locationFollowMode: Bool = true
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var naverMapView: NMFMapView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationAuthorization()
    }
    
    @IBAction func clickProfileButton(_ sender: Any) {
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showLocationAuthAlert()
            return
        }
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
    
    func logout() {
        let logoutAlert = UIAlertController(title: "로그아웃 되었습니다.", message: "로그인 페이지로 돌아갑니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { action in
            guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController else {
                return
            }
            self.present(loginVC, animated: true)
            
            // 세션 삭제 미구현
        }
        
        logoutAlert.addAction(okAction)
        present(logoutAlert, animated: true)
    }
    
    func goToChangePassword() {
        guard let changePwdVC = self.storyboard?.instantiateViewController(withIdentifier: "changePwd1") as? ChangePwdViewController1 else {
            return
        }
        self.present(changePwdVC, animated: true)
    }
    
    func goToUnsubscribe() {
        guard let unsubscribeVC = self.storyboard?.instantiateViewController(withIdentifier: "unsubscribe") as? UnsubscribeViewController1 else {
            return
        }
        self.present(unsubscribeVC, animated: true)
    }
}
