//
//  SearchPlaceService.swift
//  Promiss_iOS
//
//  Created by 임수현 on 2019/10/19.
//  Copyright © 2019 Anna Lee. All rights reserved.
//

import Foundation
import Alamofire

struct AddressService {
    static let shared = AddressService()
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "X-NCP-APIGW-API-KEY-ID" : Keys.shared.NMFClientId,
        "X-NCP-APIGW-API-KEY" : Keys.shared.NMFClientSecretKey
    ]
    
    func getSearchResult(keyword: String, latitude: Double, longitude: Double, completion: @escaping (_ places: [SearchPlaceResult.Place]) -> Void) {
        let coord = String(format: "%.6f,%.6f", longitude, latitude )
        print("coord:\(coord)")
        let searchURL = "https://naveropenapi.apigw.ntruss.com/map-place/v1/search?query=\(keyword)&coordinate=\(coord)"
        let encoded = searchURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encoded) else {return}
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            
            switch response.result{
            case .success:
                guard let result = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(SearchPlaceResult.self, from: result)
                    
                    if json.status == "OK" {
                        if let places = json.places{
                            completion(places)
                        }
                    } else {
                        print("ERROR: \(json.errorMessage!)")
                    }
                } catch {
                    print("error!\(error)")
                }
            default:
                return
            }
        }
    }
    

    func getAddress(latitude: Double, longitude: Double, completion: @escaping (_ address: Address) -> Void) {
        
        let reverseGeocodingURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=\(longitude),\(latitude)&output=json&orders=roadaddr,addr"
        Alamofire.request(reverseGeocodingURL, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON {
            response in
            print("주소 결과 응답: \(response)")
            
            switch response.result{
            case .success:
                guard let result = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(Address.self, from: result)
                    completion(json)
                } catch {
                    print("error!\(error)")
                }
            default:
                return
            }
        }
    }
}
