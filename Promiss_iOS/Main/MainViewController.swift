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
    var timer: Timer?
    var appointmentStatus: AppStatus = .Done {
        didSet{
            self.setupMainInfo()
        }
    }
    enum AppStatus {
        case Progress, Wait, Done
    }
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var naverMapView: NMFMapView!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var logoLabel: UILabel!
    
    @IBOutlet weak var appointmentNameLabel: UILabel!
    @IBOutlet weak var leftTimeLabel: UILabel!
    
    @IBOutlet weak var createOrDetailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleView()
        setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationAuthorization()
    }
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
        setupMainInfo()
    }
    
    @IBAction func clickProfileButton(_ sender: Any) {
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            showLocationAuthAlert()
            return
        }
        showProfileAlert()
    }
    
    @IBAction func clickShowMyLocation(_ sender: Any) {
        locationFollowMode = true
        updateCamera(myLocationMarker.position.lat, myLocationMarker.position.lng)
    }
    
    @IBAction func clickCreateOrDetailButton(_ sender: Any) {
        switch appointmentStatus{
        case .Progress:
            break
        case .Wait:
            goToAppointmentDetailInfo()
        case .Done:
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
            self.goToLogin()
            self.removeUserInfo()
            self.removeAppointmentInfo()
            AppointmentInfo.shared.clearAppointmentInfo()
        }
        
        logoutAlert.addAction(okAction)
        present(logoutAlert, animated: true)
    }
    
    func goToChangePassword() {
        guard let changePwdVC = self.storyboard?.instantiateViewController(withIdentifier: "changePwd") else {
            return
        }
        changePwdVC.modalPresentationStyle = .fullScreen
        self.present(changePwdVC, animated: true, completion: nil)
    }
    
    func goToUnsubscribe() {
        guard let unsubscribeVC = self.storyboard?.instantiateViewController(withIdentifier: "unsubscribe") else {
            return
        }
        unsubscribeVC.modalPresentationStyle = .fullScreen
        self.present(unsubscribeVC, animated: true, completion: nil)
    }
    
    func goToAppointmentDetailInfo() {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detail") else {return}
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func goToAddNewAppointment() {
        guard let addNewVC = self.storyboard?.instantiateViewController(withIdentifier: "addNew") else {return}
        addNewVC.modalPresentationStyle = .fullScreen
        self.present(addNewVC, animated: true, completion: nil)
    }
    
    func goToLogin(){
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController else {return}
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
}
