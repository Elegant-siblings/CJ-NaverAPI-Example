//
//  Constant.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation
import Alamofire

class Constant {
    static let shared: Constant = Constant()
    
    let FIND_PATH_BASE_URL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?"
    
    var HEADERS: HTTPHeaders {
        return ["X-NCP-APIGW-API-KEY-ID" : "ze98l8nczg",
                "X-NCP-APIGW-API-KEY" : "WZ2rtCWUOKJrKd1BJn0XEvLoqC0DELzG8yQCDnCI"
        ]
    }
    
    
}
