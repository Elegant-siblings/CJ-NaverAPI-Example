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
    
    func shortestPath(dep_lng: Double, dep_lat: Double, dest_lng: Double, dest_lat: Double, option: String) {
        let url : String = "\(Constant.shared.FIND_PATH_BASE_URL)?start=\(dep_lng),\(dep_lat)&goal=\(dest_lng),\(dest_lat)&option=\(option)"
        
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
