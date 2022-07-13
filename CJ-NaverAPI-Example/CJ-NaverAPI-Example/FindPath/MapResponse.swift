//
//  MapResponse.swift
//  CJ-NaverAPI-Example
//
//  Created by 정지윤 on 2022/07/12.
//

import Foundation

// MARK: - Welcome
struct MapResponse: Decodable {
    let code: Int
    let message, currentDateTime: String
    let route: Route
}

// MARK: - Route
struct Route: Decodable {
    let trafast: [Trafast]
}

// MARK: - Trafast
struct Trafast: Decodable {
    let summary: Summary
    let path: [[Double]]
    let section: [Section]
    let guide: [Guide]
}

// MARK: - Guide
struct Guide: Decodable {
    let pointIndex, type: Int
    let instructions: String
    let distance, duration: Int
}

// MARK: - Section
struct Section: Decodable {
    let pointIndex, pointCount, distance: Int
    let name: String
    let congestion, speed: Int
}

// MARK: - Summary
struct Summary: Decodable {
    let start: Start
    let goal: Goal
    let distance, duration, etaServiceType: Int
    let departureTime: String
    let bbox: [[Double]]
    let tollFare, taxiFare, fuelPrice: Int
}

// MARK: - Goal
struct Goal: Decodable {
    let location: [Double]
    let dir: Int
}

// MARK: - Start
struct Start: Decodable {
    let location: [Double]
}


