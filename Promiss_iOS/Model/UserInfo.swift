//
//  UserInfo.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

class UserInfo {
    static let shared: UserInfo = UserInfo()
    
    private init() {}
    
    var user_id: String!
    var appointment_id: Int!
    
    func clearUserInfo() {
        self.user_id = nil
        self.appointment_id = nil
    }
}
