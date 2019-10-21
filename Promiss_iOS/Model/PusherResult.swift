//
//  PusherResult.swift
//  Promiss_iOS
//
//  Created by 임수현 on 2019/10/20.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

struct PusherResult: Codable {
    let appointment: AppointmentData
    let members: [Member]
}

class PusherInfo {
    static let shared: PusherInfo = PusherInfo()
    private init() {}
    
    var appointment: AppointmentData!
    var members: [Member]!
    
    func savePusherInfo(data: PusherResult){
        self.appointment = data.appointment
        self.members = data.members
    }
}
