//
//  ViewController.swift
//  CJ-NaverAPI-Example
//
//  Created by 최원준 on 2022/07/04.
//

import UIKit
import CoreLocation
import NMapsMap

class ViewController: UIViewController, NMFMapViewCameraDelegate {
    
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!

    
//    lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.delegate = self
//        return manager
//    }()

    lazy var mapView: NMFMapView = {
        let map = NMFMapView(frame: view.frame)
        map.addCameraDelegate(delegate: self)
        map.allowsZooming = true
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(mapView)
        mapView.isUserInteractionEnabled = true
        
        // 서비스 권한 허용 메세지 띄우기
//        locationManager.requestWhenInUseAuthorization()
        
        let param = NMFCameraUpdateParams()
//        param.scroll(to: default_.target)
//        param.zoom(to: DEFAULT_CAMERA_POSITION.zoom)
//        mapView.moveCamera(NMFCameraUpdate(position: ))
        cameraUpdate(lat: 37.5666102, lng: 126.9783881)
        setMarker(lat: 37.5666102, lng: 126.9783881)

    }
    
    
    
//    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
//        print("카메라가 변경됨 : reason : \(reason)")
//        let cameraPosition = mapView.cameraPosition
//
//        print(cameraPosition.target.lat, cameraPosition.target.lng)
//
//    }
    
    func cameraUpdate(lat: Double, lng: Double ) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(
            lat: lat,
            lng: lng
        ))

        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    
    func setMarker(lat: Double, lng: Double) {
        let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
        marker.iconImage = NMF_MARKER_IMAGE_GREEN
        marker.mapView = mapView
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
extension ViewController: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print(latlng.lat, latlng.lng)
        
        cameraUpdate(lat: latlng.lat, lng: latlng.lng)
        setMarker(lat: latlng.lat, lng: latlng.lng)
        
        
//       let alertController = UIAlertController(title: "지도 클릭", message: latlng.positionString(), preferredStyle: .alert)
//       present(alertController, animated: true) {
//           DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5), execute: {
//               alertController.dismiss(animated: true, completion: nil)
//           })
//       }
   }
}
