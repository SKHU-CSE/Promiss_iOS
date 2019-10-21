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
        
        UserService.shared.login(userId, userPw) { loginResult in
            switch loginResult.result {
            case 1000:  //fail
                self.goToLogin()
                
            case 2000:  //success
                guard let data = loginResult.data else {return}
                
                self.idLabel.text = userId
                UserInfo.shared.saveUserInfo(id: data.id, userId: data.user_name, userPw: data.user_pw)
                
                guard let appointmentID = data.appointment_id else {
                    if self.appointmentStatus == .Progress{
                        self.disconnectPusher()
                    }
                    self.appointmentStatus = .Done
                    self.checkInvite(id: data.id)
                    return
                }
                if data.appointment_id == -1 {
                    if self.appointmentStatus == .Progress{
                        self.disconnectPusher()
                    }
                    self.appointmentStatus = .Done
                    self.checkInvite(id: data.id)
                } else {
                    self.getAppointmentInfo(id: appointmentID)
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
                    if self.appointmentStatus == .Progress{
                        self.disconnectPusher()
                    }
                    self.appointmentStatus = .Wait
                }
                // 약속 종료
                else if data.status == 2 {
                    AppointmentInfo.shared.clearAppointmentInfo()
                    if self.appointmentStatus == .Progress{
                        self.disconnectPusher()
                    }
                    self.appointmentStatus = .Done
                }
                
            case 2000: // 약속 실행 중
                guard let data = appointmentResult.data else {return}
                AppointmentInfo.shared.saveAppointmentInfo(data: data)
                
                if (self.appointmentStatus != .Progress) {
                    self.connectPusher()
                }
                self.appointmentStatus = .Progress
                
            default:
                break
            }
            self.getLeftTime()
        })
    }
    
    func checkInvite(id: Int) {
        AppointmentService.shared.checkInvite(id: id) { result in
            switch result.result{
            case 2000:
                self.showInviteMessage(appointmentName: result.data?.name ?? "약속")
            default:
                break
            }
        }
    }
    
    func acceptInvite(accept: Bool){
        AppointmentService.shared.acceptInvite(id: UserInfo.shared.id, accept: accept) { (data) in
            AppointmentInfo.shared.saveAppointmentInfo(data: data)
            switch data.status {
            case 0:
                if self.appointmentStatus == .Progress{ self.disconnectPusher() }
                self.appointmentStatus = .Wait
            case 1:
                if (self.appointmentStatus != .Progress) { self.connectPusher() }
                self.appointmentStatus = .Progress
            case 2:
            if self.appointmentStatus == .Progress{ self.disconnectPusher() }
                self.appointmentStatus = .Done
            default:
                return
            }
            self.setupMainInfo()
            self.getLeftTime()
        }
    }
    
    func updateMyLocation(lat: Double, lng: Double){
        guard let id = UserInfo.shared.id else {return}
        UserService.shared.updateMyLoction(id: id, lat: lat, lng: lng)
    }
}
