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
                self.saveUserInfo(id: data.id, userId: data.user_name, userPw: data.user_pw)
                self.idLabel.text = userId
                
                if data.appointment_id == -1 {
                    self.appointmentStatus = .Done
                } else {
                    self.getAppointmentInfo(id: data.appointment_id)
                }
                
            default:
                return
            }
        }
    }
    
    func getAppointmentInfo(id: Int){
        AppointmentService.shared.getAppointmentInfo(id: id, completion: { appointmentResult in
            switch appointmentResult.result{
            case 1000: // 약속 미실행 중
                guard let data = appointmentResult.message else {return}
                // 약속 대기중
                if data.status == 0 {
                    AppointmentInfo.shared.saveAppointmentInfo(data: data)
                    self.appointmentStatus = .Wait
                }
                // 약속 종료
                else if data.status == 2 {
                    AppointmentInfo.shared.clearAppointmentInfo()
                    self.appointmentStatus = .Done
                }
                
            case 2000: // 약속 실행 중
                guard let data = appointmentResult.data else {return}
                AppointmentInfo.shared.saveAppointmentInfo(data: data)
                self.appointmentStatus = .Progress
                
            default:
                break
            }
            self.getLeftTime()
        })
    }
    
    private func saveUserInfo(id: Int, userId: String, userPw: String){
        UserDefaults.standard.set(userId, forKey: "id")
        UserDefaults.standard.set(userPw, forKey: "pw")
        
        UserInfo.shared.id = id
        UserInfo.shared.userId = userId
    }
    
    func removeUserInfo(){
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
        
        UserInfo.shared.clearUserInfo()
    }
    
    func removeAppointmentInfo(){
        self.timer?.invalidate()
        AppointmentInfo.shared.clearAppointmentInfo()
    }
}
