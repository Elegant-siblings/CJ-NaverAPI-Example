//
//  MapProtocol.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation

protocol MapDataManagerDelegate{
    func shortestPath(dep_lng: String, dep_lat: String, dest_lng: String, dest_lat: String, option: String)
}

protocol ViewControllerDelegate: AnyObject{
    func didSuccessReturnPath(result: Trafast)
    func failedToRequest(message: String)
}
