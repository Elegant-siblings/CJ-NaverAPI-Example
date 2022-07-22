//
//  MapDataManager.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation
import Alamofire

class MapDataManager: MapDataManagerDelegate {
    
    weak var delegate: ViewControllerDelegate?
    
    init(delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func shortestPath(depLng: Double, depLat: Double, destLng: Double, destLat: Double, wayPoints: String?, option: String) {
        
        var urlString = ""
        
        if let wayPoints = wayPoints {
            urlString = "\(Constant.shared.FIND_PATH_BASE_URL)?start=\(depLng),\(depLat)&goal=\(destLng),\(destLat)&waypoints=\(wayPoints)&option=\(option)"
        } else {
            urlString = "\(Constant.shared.FIND_PATH_BASE_URL)?start=\(depLng),\(depLat)&goal=\(destLng),\(destLat)&option=\(option)"
        }
        
        
        // 왜 이 처리를 해야되지?
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded) {
            
            print(url)
            AF.request(url,
                       method: .get,
                       headers: Constant.shared.HEADERS).validate().responseDecodable(of: MapResponse.self) { (response) in
                switch response.result {
                case .success(let response):
                    print(response.code)
                    if response.code == 0 {
                        let result = response.route!.trafast[0]
                        self.delegate?.didSuccessReturnPath(result: result)
                    } else {
                        self.delegate?.failedToRequest(message: response.message)
                    }
                case .failure(let error):
                    print(error)
                    self.delegate?.failedToRequest(message: "서버")
                }
            }
        }
        
    }
}
