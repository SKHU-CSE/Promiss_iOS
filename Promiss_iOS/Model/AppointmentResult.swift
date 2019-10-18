//
//  AppointmentResult.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

struct AppointmentResult: Codable{
    
    
    let result: Int
    let data: AppointmentData?
    let message: AppointmentData?
    
    struct AppointmentData: Codable {
        let id: Int
        let status: Int?
        let name: String
        let address: String
        let detail: String
        let latitude: Double
        let longitude: Double
        let date: String
        let date_time: String
        let radius: Double
        let Fine_money: Int
        let Fine_time: Int
        let Fine_current: Int
        let main_user_id: Int
    }
}
