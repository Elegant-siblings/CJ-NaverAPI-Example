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
    
    func shortestPath(dep_lng: String, dep_lat: String, dest_lng: String, dest_lat: String, option: String) {
        let url : String = "\(Constant.shared.FIND_PATH_BASE_URL)?start=\(dep_lng),\(dep_lat)&goal=\(dest_lng),\(dest_lat)&option=\(option)"
        
        AF.request(url,
                   method: .get,
                   headers: Constant.shared.HEADERS).validate().responseDecodable(of: MapResponse.self) { (response) in
            switch response.result {
            case .success(let response):
                if response.code == 0 {
                    let result = response.route.trafast[0]
                    self.delegate?.didSuccessReturnPath(result: result)
                } else {
                    self.delegate?.failedToRequest(message: response.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.failedToRequest(message: "서버")
            }
        }
    }
}
