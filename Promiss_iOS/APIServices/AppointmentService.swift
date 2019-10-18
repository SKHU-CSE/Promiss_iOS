//
//  AppointmentService.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import Alamofire

struct AppointmentService {
    static let shared = AppointmentService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func addAppointment(id: Int, name: String, address: String, detail: String, latitude: Double, longitude: Double, date: String, time: String, fineTime: Int, fineMoney: Int, members: [Int], completion: @escaping (_ result: AppointmentResult) -> Void) {
        
        var body: Parameters = [
            "id": id,
            "name": name,
            "address": address,
            "detail": detail,
            "latitude": latitude,
            "longitude": longitude,
            "date": date,
            "date_time": time,
            "Fine_time": fineTime,
            "Fine_money": fineMoney,
            "num": members.count
        ]
        
        for i in 0..<members.count {
            body.updateValue(members[i], forKey: "member_id\(i)")
        }
        
        Alamofire.request(APIConstants.NewAppURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print("약속만들기 응답:\(response)")
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(AppointmentResult.self, from: result)
                    
                    completion(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getAppointmentInfo(id: Int, completion: @escaping (_ result: AppointmentResult) -> Void) {
        
        let body: Parameters = [
            "id": id
        ]
        
        Alamofire.request(APIConstants.AppInfoURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print("약속 정보 응답: \(response)")
            
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(AppointmentResult.self, from: result)
                    
                    completion(json)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
                
        }
    }
}
