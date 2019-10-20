//
//  MainViewController+location.swift
//  Promiss_iOS
//
//  Created by 임수현 on 24/09/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import UIKit
import NMapsMap
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    func checkLocationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        print("위치 권한체크 \(status)")
        switch status {
        case .notDetermined:    // 최초 확인
            print("최초확인")
            setupLocationManager()
        
        case .restricted:       // 권한 제한
            print("권한 제한")
            showLocationAuthAlert()
        
        case .denied:           // 권한 거부
            print("권한 거부")
            showLocationAuthAlert()
        
        case .authorizedAlways: // 항상 허용
            print("항상 허용")
            setupLocationManager()
        
        case .authorizedWhenInUse:  // 사용할 때만 허용
            print("사용할때만 허용")
            showLocationAuthAlert()
        }
    }
    
    func showLocationAuthAlert() {
        let alert = UIAlertController(title: "위치 권한", message: "프로미스를 사용하려면 항상 위치정보 사용에 동의해야 합니다.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "설정으로 이동", style: .default, handler: {
            action in
            if let appSettings = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // 항상 위치정보를 사용한다는 판업이 발생
        locationManager.startUpdatingLocation()
        print("updateLoction")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate{
            print("\(String(coor.latitude))/\(String(coor.longitude))")
            UserInfo.shared.longitude = coor.longitude
            UserInfo.shared.latitude = coor.latitude
            
            updateLocationMarker(coor.latitude, coor.longitude)
            if locationFollowMode {
                print("followmode")
                updateCamera(coor.latitude, coor.longitude)
            }
        }
    }
}
