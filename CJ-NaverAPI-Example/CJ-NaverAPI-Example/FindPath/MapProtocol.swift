//
//  MapProtocol.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation

protocol MapDataManagerDelegate{
    func shortestPath(depLng: Double, depLat: Double, destLng: Double, destLat: Double, wayPoints: String?, option: String)
}

protocol ViewControllerDelegate: AnyObject{
    func didSuccessReturnPath(result: Trafast)
    func failedToRequest(message: String)
}
