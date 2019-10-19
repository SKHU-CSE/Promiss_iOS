//
//  SearchPlaceResult.swift
//  Promiss_iOS
//
//  Created by 임수현 on 2019/10/19.
//  Copyright © 2019 Anna Lee. All rights reserved.
//
import Foundation


struct SearchPlaceResult: Codable {
    struct Meta:Codable{
        let totalCount: Int
        let count: Int
    }
    struct Place:Codable {
        let name: String
        let road_address: String
        let jibun_address: String
        let phone_number: String
        let x: String
        let y: String
        let distance: Double
        let sessionId: String
        
        func address() -> String{
            if road_address == "" {
                return jibun_address
            }
            return road_address
        }
    }
    
    let status: String
    let meta: Meta?
    let places: [Place]?
    let errorMessage: String?
}

struct ResultList {
    var name: String
    var address: String
    var distance: Double
    var x: String
    var y: String
}

struct Address:Codable {
    
    struct Coord:Codable {
        struct Center:Codable{
            let crs: String // 좌표계코드
            let x: Float    // 위도
            let y: Float    // 경도
        }
        let center: Center
    }
    
    struct Status: Codable {
        let code: Int
        let name: String
        let message: String
    }
    
    struct Result: Codable {
        
        struct Code:Codable {
            let id: String
            let type: String
            let mappingId: String
        }
        
        struct Region: Codable {
            struct Area: Codable {
                let name: String    // 이름
                let coords: Coord   // 행정구역
                let alis: String?   // 별칭
            }
            let area0: Area    // 국가
            let area1: Area    // 광역시도
            let area2: Area    // 시, 군, 구
            let area3: Area    // 읍 면 동
            let area4: Area    // 리
        }
        
        struct Land: Codable {
            struct Addition: Codable {
                let type: String?
                let value: String?
            }
            let type: String    // 지번주소 경우 1:토지 2:산 / 도로명일 경우 ""
            let name: String?    // 지번주소 경우 "" / 도로명
            let number1: String // 지번주소 경우 토지 본번호 / 도로명의 경우 상세주소
            let number2: String // 지번주소 경우 토지 부번호 / 도로명의 경우 ""
            
            // 도로명일 경우만 발생
            let addition0: Addition?    // 건물(building)
            let addition1: Addition?    // 우편번호(zipcode)
            let addition2: Addition?    // 도로 코드(roadGroupCode)
            let addition3: Addition?    // reserved
            let addition4: Addition?    // reserved
            let coords: Coord?  // 행정 구역
        }
        
        let name: String    // 변환 작업 이름 (주소 유형)
        let code: Code      // 코드 정보
        let region: Region  // 지역 명칭 정보
        let land: Land?      // 상세 주소 정보
    }
    
    let status: Status
    let results: [Result]
    
    // 도로명 주소 받아오기
    var fullRoadAdress:String {
        var address = "도로명 주소가 없습니다."
        if self.results.count > 0 {
            for res in results {
                if res.name == "roadaddr"{
                    var num2 = ""
                    if res.land!.number2 != "" {
                        num2 = "-" + res.land!.number2
                    }
                    guard let landname = res.land!.name else {
                        address = "주소 정보 로드에 문제가 생겼습니다."
                        continue
                    }
                     address = "\(res.region.area1.name) \(res.region.area2.name) \(landname) \(res.land!.number1)\(num2)"
                    break
                }
            }
            return address
        } else { return "결과가 없습니다." }
    }
    
    // 지번주소 받아오기
    var fullJibunAddress: String {
        var address = "주소 정보가 없습니다."
        if self.results.count>0{
            for res in results {
                if res.name == "addr"{
                    var name4 = ""
                    if res.region.area4.name != ""{
                        name4 = "\(res.region.area4.name) "
                    }
                    var num1 = ""
                    if res.land!.number1 != "" {
                        num1 = res.land!.number1
                    }
                    var num2 = ""
                    if res.land!.number2 != "" {
                        num2 = "-\(res.land!.number2)"
                    }
                    address = "\(res.region.area1.name) \(res.region.area2.name) \(res.region.area3.name) \(name4) \(num1)\(num2)"
                    break
                }
            }
        }
        return address
    }
    
    // 도로명 먼저 받아오고, 없으면 지번주소
    var roadNextJibun: String {
        var address = "주소 정보가 없습니다."
        var isHavingJibun: Bool = false;
        if self.results.count>0{
            for res in results {
                if res.name == "addr" && !isHavingJibun{
                    isHavingJibun = true
                    var name4 = ""
                    if res.region.area4.name != ""{
                        name4 = "\(res.region.area4.name) "
                    }
                    var num1 = ""
                    if res.land!.number1 != "" {
                        num1 = res.land!.number1
                    }
                    var num2 = ""
                    if res.land!.number2 != "" {
                        num2 = "-\(res.land!.number2)"
                    }
                    address = "\(res.region.area1.name) \(res.region.area2.name) \(res.region.area3.name) \(name4) \(num1)\(num2)"
                } else if res.name == "roadaddr"{
                    var num2 = ""
                    if res.land!.number2 != "" {
                        num2 = "-" + res.land!.number2
                    }
                    guard let landname = res.land!.name else {
                        address = "주소 정보 로드에 문제가 생겼습니다."
                        break
                    }
                    address = "\(res.region.area1.name) \(res.region.area2.name) \(landname) \(res.land!.number1)\(num2)"
                    break
                }
            }
        }
        return address
    }
}

