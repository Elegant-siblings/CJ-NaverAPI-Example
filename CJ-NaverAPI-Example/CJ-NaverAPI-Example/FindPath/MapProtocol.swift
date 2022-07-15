//
//  MapProtocol.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation

protocol MapDataManagerDelegate{
    func shortestPath(dep_lng: Double, dep_lat: Double, dest_lng: Double, dest_lat: Double, option: String)
}

protocol ViewControllerDelegate: AnyObject{
    func didSuccessReturnPath(result: Trafast)
    func failedToRequest(message: String)
}
