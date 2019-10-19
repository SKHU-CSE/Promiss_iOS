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
    
    
    func saveUserInfo(id: Int, userId: String, userPw: String){
        UserDefaults.standard.set(userId, forKey: "id")
        UserDefaults.standard.set(userPw, forKey: "pw")
        
        self.id = id
        self.userId = userId
    }
    
    func clearUserInfo(){
        id = -1
        userId = "unknown"
        latitude = nil
        longitude = nil
        
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pw")
    }
}

class AppointmentInfo {
    static let shared: AppointmentInfo = AppointmentInfo()
    private init() {}
    
    var timer: Timer?
    
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
        timer?.invalidate()
        
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
    
    func saveAppointmentInfo(data: AppointmentData){
        id = data.id
        name = data.name
        address = data.address
        detailAddress = data.detail
        latitude = data.latitude
        longitude = data.longitude
        radius = data.radius
        fineMoney = data.fineMoney
        fineTime = data.fineTime
        fineCurrent = data.fineCurrent
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        time = dateFormatter.date(from: "\(data.date) \(data.dateTime)") ?? Date()
    }
}
