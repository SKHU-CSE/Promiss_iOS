//
//  MainViewController.swift
//  Promiss_iOS
//
//  Created by 임수현 on 04/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var isInProgress: Bool = false
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var leftTimeLabel: UILabel!
    
    @IBOutlet weak var createOrDetailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
        setupMainInfo()
    }
    
    @IBAction func clickProfileButton(_ sender: Any) {
        showProfileAlert()
    }
    
    @IBAction func clickCreateOrDetailButton(_ sender: Any) {
        if isInProgress {
            goToAppointmentDetailInfo()
        } else {
            goToAddNewAppointment()
        }
    }
}

extension MainViewController {
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
        guard let changePwdVC = self.storyboard?.instantiateViewController(withIdentifier: "changePwd") else {
            return
        }
        self.present(changePwdVC, animated: true, completion: nil)
    }
    
    func goToUnsubscribe() {
        guard let unsubscribeVC = self.storyboard?.instantiateViewController(withIdentifier: "unsubscribe") as? UnsubscribeViewController1 else {
            return
        }
        self.present(unsubscribeVC, animated: true)
    }
    
    func goToAppointmentDetailInfo() {
        
    }
    
    func goToAddNewAppointment() {
        guard let addNew = self.storyboard?.instantiateViewController(withIdentifier: "addNew") else {return}
        self.present(addNew, animated: true, completion: nil)
    }
}
