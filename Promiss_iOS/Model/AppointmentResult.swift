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
}

struct AppointmentData: Codable {
    let id: Int
    let status: Int?
    let name: String
    let address, detail: String
    let latitude, longitude: Double
    let date, dateTime: String
    let radius: Double
    let fineMoney, fineTime, fineCurrent: Int
    let mainUserID: Int
    let members: [Member]?
    
    enum CodingKeys: String, CodingKey {
        case id, status, name
        case address, detail, latitude, longitude
        case date
        case dateTime = "date_time"
        case radius
        case fineMoney = "Fine_money"
        case fineTime = "Fine_time"
        case fineCurrent = "Fine_current"
        case mainUserID = "main_user_id"
        case members
    }
}

struct Member: Codable {
    let appointmentID: Int
    let id, userID: Int
    let userName, userPw: String
    let latitude, longitude: Double
    let distance, success: Int
    let fineCurrent, fineFinal: Int
    let lastDate: String

    enum CodingKeys: String, CodingKey {
        case fineCurrent = "Fine_current"
        case fineFinal = "Fine_final"
        case appointmentID = "appointment_id"
        case distance, id
        case lastDate = "last_date"
        case latitude, longitude, success
        case userID = "user_id"
        case userName = "user_name"
        case userPw = "user_pw"
    }
}
