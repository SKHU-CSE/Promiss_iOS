//
//  APIConstants.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation

struct APIConstants {
    static let BaseURL: String = "http://106.10.54.206/api"
    
    static let gpsURL: String = BaseURL + "/gpsUpdate"
    
    static let UserURL: String = BaseURL + "/User"
    static let LoginURL: String = UserURL + "/Login"
    static let SignupURL: String = UserURL + "/register"
    static let DeleteURL: String = UserURL + "/delete"
    static let ChangePwdURL: String = UserURL + "/changePassword"
    static let SearchURL: String = UserURL + "/search"
    
    static let AppointmentURL: String = BaseURL + "/Appointment"
    static let NewAppURL: String = AppointmentURL + "/newAppointment"
    static let NewMemberURL: String = AppointmentURL + "/newMember"
    static let CheckInviteURL: String = AppointmentURL + "/CheckInvite"
    static let AcceptInviteURL: String = AppointmentURL + "/acceptInvite"
    static let AppInfoURL: String = AppointmentURL + "/getAppointment"
    static let AppDetailInfoURL: String = AppointmentURL + "/getAppointment_detail"
}
