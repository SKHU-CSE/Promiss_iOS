//
//  UserInfo.swift
//  Promiss_iOS
//
//  Created by 임수현 on 18/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

class UserInfo{
    static let shared: UserInfo = UserInfo()
    private init() {}
    
    var id: Int!
    var userId: String!
    var latitude: Double?
    var longitude: Double?
    
    func clearUserInfo(){
        id = -1
        userId = "unknown"
        latitude = nil
        longitude = nil
    }
}

class AppointmentInfo {
    static let shared: AppointmentInfo = AppointmentInfo()
    private init() {}
    
    var id: Int!
    var status: Int!
    var name: String!
    var address: String!
    var detailAddress: String?
    var latitude: Double!
    var longitude: Double!
    var time: Date!
    var radius: Double?
    var fineMoney: Int!
    var fineTime: Int!
    var fineCurrent: Int!
    var leftTime: Int! // seconds
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: time)
    }
    
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: time)
    }
    
    func clearAppointmentInfo(){
        id = -1
        status = nil
        name = nil
        address = nil
        detailAddress = nil
        latitude = nil
        longitude = nil
        time = nil
        radius = nil
        fineMoney = nil
        fineTime = nil
        fineCurrent = nil
    }
    
    func saveAppointmentInfo(data: AppointmentResult.AppointmentData){
        id = data.id
        name = data.name
        address = data.address
        detailAddress = data.detail
        latitude = data.latitude
        longitude = data.longitude
        radius = data.radius
        fineMoney = data.Fine_money
        fineTime = data.Fine_time
        fineCurrent = data.Fine_current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        time = dateFormatter.date(from: "\(data.date) \(data.date_time)") ?? Date()
    }
}
