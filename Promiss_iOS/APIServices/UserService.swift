//
//  AuthServices.swift
//  Promiss_iOS
//
//  Created by 임수현 on 17/10/2019.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import Alamofire

struct UserService {
    
    static let shared = UserService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signup(_ id: String, _ password: String, completion: @escaping (_ result: UserResult) -> Void) {
        
        let body: Parameters = [
            "id": id,
            "pw": password
        ]
        
        Alamofire.request(APIConstants.SignupURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print("회원가입 응답: \(response)")
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(UserResult.self, from: result)
                    completion(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func login(_ id: String, _ password: String, completion: @escaping (_ result: UserResult) -> Void) {
        
        let body: Parameters = [
            "id": id,
            "pw": password
        ]
        
        Alamofire.request(APIConstants.LoginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print("로그인 응답: \(response)")
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(UserResult.self, from: result)
                    completion(json)
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func findUser(userID: String, completion: @escaping (_ result: [UserData?]) -> Void ){
        let body: Parameters = [
           "ID": userID
       ]
               
        Alamofire.request(APIConstants.SearchUserURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            print("회원검색 응답: \(response)")
            switch response.result {
            case .success:
                guard let result = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(SearchUserResult.self, from: result)
                    switch json.result {
                    case 2000:
                        completion(json.data)
                    default:
                        return
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
