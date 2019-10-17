//
//  MainViewController+user.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    func checkUserInfo() {
        guard let userId = UserDefaults.standard.string(forKey: "id"), let userPw = UserDefaults.standard.string(forKey: "pw") else {
            self.goToLogin()
            return
        }
        
        LoginService.shared.login(userId, userPw) { loginResult in
            switch loginResult.result {
            case 1000:  //fail
                self.goToLogin()
                
            case 2000:  //success
                guard let data = loginResult.data else {return}
                self.saveUserInfo(id: data.user_name, pw: data.user_pw, appointment: data.appointment_id)
                self.idLabel.text = userId
            default:
                return
            }
        }
    }
    
    private func saveUserInfo(id: String, pw: String, appointment: Int){
        UserDefaults.standard.set(id, forKey: "id")
        UserDefaults.standard.set(pw, forKey: "pw")
        UserDefaults.standard.set(appointment, forKey: "appointment")
    }
    
    func removeUserInfo(){
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        UserDefaults.standard.removeObject(forKey: "appointment")
    }
}
