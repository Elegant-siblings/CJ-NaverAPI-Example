//
//  ViewController.swift
//  CJ-NaverAPI-Example
//
//  Created by 최원준 on 2022/07/04.
//

import UIKit
import CoreLocation
import NMapsMap
import SnapKit


//public let DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat: 37.5666102, lng: 126.9783881), zoom: 14, tilt: 0, heading: 0)

class ViewController: UIViewController {
    
    
    let bounds1 = NMGLatLngBounds(southWest: NMGLatLng(lat: 37.4282975, lng: 126.7644840),
                                  northEast: NMGLatLng(lat: 37.7014553, lng: 127.1837949))
    let bounds2 = NMGLatLngBounds(southWest: NMGLatLng(lat: 34.8357234, lng: 128.7614072),
                                  northEast: NMGLatLng(lat: 35.3890374, lng: 129.3055979))
    var boundsFlag = false
    
    
    
    let pathButton = UIButton().then {
        $0.backgroundColor = .green
        $0.setTitle("경로 찾기", for: .normal)
    }
    
    let distanceLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "이동거리"
    }
    
    let timeLabel = UILabel().then {
        $0.textColor = .black
        $0.text = "이동시간"
    }
    
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!

    
    var progressPathOverlay: NMFPath?
    
    
    lazy var dataManager = MapDataManager(delegate: self)

    

    let mapView = NMFMapView().then{
        $0.allowsZooming = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        
        view.addSubview(mapView)
        view.addSubview(pathButton)
        view.addSubview(distanceLabel)
        view.addSubview(timeLabel)

        pathButton.addTarget(self, action: #selector(findPath), for: .touchUpInside)
        setConstraints()
        
        
        let ne1 = NMFMarker(position: bounds1.northEast)
        ne1.mapView = mapView
        let sw1 = NMFMarker(position: bounds1.southWest)
        sw1.mapView = mapView
        let ne2 = NMFMarker(position: bounds2.northEast)
        ne2.mapView = mapView
        let sw2 = NMFMarker(position: bounds2.southWest)
        sw2.mapView = mapView
        
//        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        
    }
    
    
    
    func setConstraints() {

        mapView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.height.equalTo(500)
            make.top.equalTo(self.view)
        }
        
        // UIButton
        pathButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerX.equalTo(self.view)
            make.top.equalTo(mapView.snp.bottom).offset(30)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(pathButton.snp.bottom).offset(20)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
        }
    }

    
    
    func setMarker(lat: Double, lng: Double) {
        let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
        marker.iconImage = NMF_MARKER_IMAGE_GREEN
        marker.mapView = mapView
    }
    
    func initPath() {
        let width: CGFloat = 8
        let outlineWidth: CGFloat = 2
        
        if let pathOverlay = NMFPath(points: CoordsData.coords1) {
            pathOverlay.width = width
            pathOverlay.outlineWidth = outlineWidth
            pathOverlay.color = .green
            pathOverlay.outlineColor = UIColor.white
            pathOverlay.passedColor = UIColor.gray
            pathOverlay.passedOutlineColor = UIColor.white
            pathOverlay.progress = 0.3
            pathOverlay.mapView = mapView
            progressPathOverlay = pathOverlay
        }
    }
    
    @objc func findPath() {
        print("touched")
        dataManager.shortestPath(dep_lng: 126.7644840, dep_lat: 37.4282975, dest_lng: 128.7614072, dest_lat: 34.8357234, option: "trafast")
    }
}


extension NMGLatLng {
    func positionString() -> String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}



extension ViewController: ViewControllerDelegate{
    func didSuccessReturnPath(result: Trafast){
        for i in result.path {
            CoordsData.coords1.append(NMGLatLng(lat: i[1], lng: i[0]))
        }
        initPath()
        
        distanceLabel.text = "이동거리: \(result.summary.distance / 1000)km"
        
        let milliseconds = result.summary.duration
        let hours = ((milliseconds / (1000*60*60)) % 24)
        let mins = ((milliseconds / (1000*60)) % 60)
        timeLabel.text = "이동시간: \(hours)시간 \(mins)분"
        
        let camUpdate = NMFCameraUpdate(fit: boundsFlag ? bounds2 : bounds1, padding: 24)
        camUpdate.animation = .fly
        camUpdate.animationDuration = 5
        mapView.moveCamera(camUpdate)
        boundsFlag = !boundsFlag
    }
    func failedToRequest(message: String){
        print(message)
    }
}

struct CoordsData {
   static var coords1 = [NMGLatLng()]
}


