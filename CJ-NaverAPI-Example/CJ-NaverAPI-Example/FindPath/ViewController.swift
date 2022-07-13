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


public let DEFAULT_CAMERA_POSITION = NMFCameraPosition(NMGLatLng(lat: 37.5666102, lng: 126.9783881), zoom: 14, tilt: 0, heading: 0)

class ViewController: UIViewController {
    
//    let rectView = UIView().then{
//        $0.backgroundColor = .white
//    }
//
    
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
//
//    var mapView: NMFMapView {
//        return naverMapView.mapView
//    }
    
    
    var progressPathOverlay: NMFPath?
    
    
    lazy var dataManager = MapDataManager(delegate: self)

    
//    lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.delegate = self
//        return manager
//    }()

//    lazy var mapView: NMFMapView = {
//        let map = NMFMapView(frame: view.frame)
//        map.addCameraDelegate(delegate: self)
//        map.allowsZooming = true
//        return map
//    }()
    
    let mapView = NMFMapView().then{
//        $0.addCameraDelegate(delegate: self)
        $0.allowsZooming = true
//        $0.frame = view.frame
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        
        view.addSubview(mapView)
        view.addSubview(pathButton)
        view.addSubview(distanceLabel)
        view.addSubview(timeLabel)
//        rectView.addSubview(mapView)
//        mapView.touchDelegate = self
//        mapView.delegate = self
        mapView.isUserInteractionEnabled = true
        pathButton.addTarget(self, action: #selector(findPath), for: .touchUpInside)
        setConstraints()
        
        // 서비스 권한 허용 메세지 띄우기
//        locationManager.requestWhenInUseAuthorization()
        
//        let param = NMFCameraUpdateParams()
//        param.scroll(to: default_.target)
//        param.zoom(to: DEFAULT_CAMERA_POSITION.zoom)
//        mapView.moveCamera(NMFCameraUpdate(position: ))
//        cameraUpdate(lat: 37.5666102, lng: 126.9783881)
//        setMarker(lat: 37.5666102, lng: 126.9783881)
        
        mapView.moveCamera(NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION))
        
    }
    
    
    
//    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
//        print("카메라가 변경됨 : reason : \(reason)")
//        let cameraPosition = mapView.cameraPosition
//
//        print(cameraPosition.target.lat, cameraPosition.target.lng)
//
//    }
    
    func setConstraints() {
//        rectView.snp.makeConstraints { make in
////            make.edges.equalToSuperview()
//            make.width.equalTo(self.view)
//            make.height.equalTo(500)
//            make.top.equalTo(self.view)
//        }
//
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
//            make.top.equalToSuperview().offset(50)
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
    
//    func cameraUpdate(lat: Double, lng: Double ) {
//        let update = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
//
////        cameraUpdate.animation = .easeIn
//        mapView.moveCamera(update)
//    }
    
    
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
        dataManager.shortestPath(dep_lng: "126.9783881", dep_lat: "37.5666102", dest_lng: "129.075986", dest_lat: "35.17947", option: "trafast")
    }
}


extension NMGLatLng {
    func positionString() -> String {
        return String(format: "(%.5f, %.5f)", lat, lng)
    }
}

// 내 위치 받아오기
//extension ViewController: CLLocationManagerDelegate{
//
//    func getLocationUsagePermission() {
//        self.locationManager.requestWhenInUseAuthorization()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("GPS 권한 설정됨")
//            self.locationManager.startUpdatingLocation() // 중요!
//
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(
//                lat: locationManager.location?.coordinate.latitude ?? 0,
//                lng: locationManager.location?.coordinate.longitude ?? 0
//            ))
//
//            cameraUpdate.animation = .easeIn
//            mapView.moveCamera(cameraUpdate)
//
//        case .restricted, .notDetermined:
//            print("GPS 권한 설정되지 않음")
//            getLocationUsagePermission()
//        case .denied:
//            print("GPS 권한 요청 거부됨")
//            getLocationUsagePermission()
//        default:
//            print("GPS: Default")
//        }
//    }
//}

// 클릭 시 이벤트
//extension ViewController: NMFMapViewTouchDelegate {
//    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
//        print(latlng.lat, latlng.lng)
//
//        cameraUpdate(lat: latlng.lat, lng: latlng.lng)
//        setMarker(lat: latlng.lat, lng: latlng.lng)
//
//
////       let alertController = UIAlertController(title: "지도 클릭", message: latlng.positionString(), preferredStyle: .alert)
////       present(alertController, animated: true) {
////           DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5), execute: {
////               alertController.dismiss(animated: true, completion: nil)
////           })
////       }
//
//
//        if let pathOverlay = progressPathOverlay {
//            let progress = NMFGeometryUtils.progress(with: pathOverlay.path.points as! [NMGLatLng], targetLatLng: latlng)
//            pathOverlay.progress = Double(progress)
//        }
//   }
//}


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
        
    }
    func failedToRequest(message: String){
        print(message)
    }
}

struct CoordsData {
   static var coords1 = [NMGLatLng()]
}


