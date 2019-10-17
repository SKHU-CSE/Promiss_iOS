//
//  AuthServices.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import Alamofire

struct SignupService {
    
    static let shared = SignupService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signup(_ id: String, _ password: String, completion: @escaping (_ result: SignUpResult) -> Void) {
        
        let body: Parameters = [
            "id": id,
            "pw": password
        ]
        
        Alamofire.request(APIConstants.SignupURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print(response)
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(SignUpResult.self, from: result)
                    
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
