//
//  MainViewController+timer.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

extension MainViewController {
    func getLeftTime() {
        let current = Date(timeIntervalSinceNow: 9*60*60)
        let interval = AppointmentInfo.shared.time.timeIntervalSince(current)
        AppointmentInfo.shared.leftTime = Int(interval)
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
    }
    
    @objc func decreaseTime(){
        guard let leftTime = AppointmentInfo.shared.leftTime else {return}
        print(leftTime)
        
        if leftTime >= 0 {
            if leftTime < 7200 {
                appointmentStatus = .Progress
            } else {
                appointmentStatus = .Wait
            }
            AppointmentInfo.shared.leftTime -= 1
            leftTimeLabel.text = getLeftTimeString(time: leftTime)
        } else { // 시간 종료 시
            timer?.invalidate()
            self.navigationController?.popViewController(animated: false)
            appointmentStatus = .Done
        }
    }
    
    func getLeftTimeString(time: Int) -> String{
        let hour = time/(60*60)
        let min = time%(60*60)/60
        let sec = time%(60*60)%60
        let str = String(format: "%02d:%02d:%02d", hour, min, sec)
        
        return str
    }
}
