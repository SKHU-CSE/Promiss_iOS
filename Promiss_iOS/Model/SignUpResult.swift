//
//  SignUpResult.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

struct SignUpResult: Codable {
    let result: Int
    let message: String?
    let data: UserData?
    
    struct UserData: Codable {
        let id: Int?
        let user_name: String?
        let user_pw: String?
        let appointment_id: Int?
        let last_date: String?
    }
}

