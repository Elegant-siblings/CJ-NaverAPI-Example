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
import Then


class ViewController: UIViewController {
    
    
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
    
    private let locationManager = NMFLocationManager.sharedInstance()
    
    var longitude: CLLocationDegrees!
    var latitude: CLLocationDegrees!

    //출발 & 도착 위치 정보: southWest -> 출발, nortEast -> 도착
//    let departLocation = NMGLatLng(lat: 37.7014553, lng: 126.7644840)
//    let destLocation = NMGLatLng(lat: 37.4282975, lng: 127.1837949)
    let bounds1 = NMGLatLngBounds(southWest: NMGLatLng(lat: 37.4282975, lng: 126.7644840),
                                  northEast: NMGLatLng(lat: 37.7014553, lng: 127.1837949))
    
    let way1 = NMGLatLng(lat: 37.55484, lng: 127.15238)
    let way2 = NMGLatLng(lat: 37.62344, lng: 127.20376)
        // 경유지 위치 정보
//    let wayPoints : [[Double]]?
//    var wayPointsToString : String? = ""
    
    //경로
    var progressMultipartPath: NMFMultipartPath?
    var coords = [NMGLatLng]()
    var stringCoords = [NMGLineString<NMGLatLng>]()
    var wayPointIdx : [Int] = []
    
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
        
        locationManager?.add(self)
//        mapView.addObserver(self, forKeyPath: "positionMode", options: [.new, .old, .prior], context: nil)
        self.mapView.positionMode = .direction

        pathButton.addTarget(self, action: #selector(findPath), for: .touchUpInside)
        setConstraints()
        
        // 출발 & 도착 위치 마커 찍기
        let departMark = NMFMarker(position: bounds1.southWest)
        departMark.mapView = mapView
        let destMark = NMFMarker(position: bounds1.northEast)
        destMark.mapView = mapView
        let way1Mark = NMFMarker(position: NMGLatLng(lat: way1.lat, lng: way1.lng))
        way1Mark.mapView = mapView
        let way2Mark = NMFMarker(position: NMGLatLng(lat: way2.lat, lng: way2.lng))
        way2Mark.mapView = mapView
        
        
//        if let way = wayPoints {
//            for i in way {
//                wayPointsToString! += i.map({"\($0)"}).joined(separator: ",")
//            }
//            wayPointsToString! += "|"
//        } else {
//            wayPointsToString = nil
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let DEFAULT_CAMERA_POSITION = NMFCameraPosition(locationManager!.currentLatLng(), zoom: 14, tilt: 0, heading: 0)
//        let camUpdate = NMFCameraUpdate(position: DEFAULT_CAMERA_POSITION)
//        camUpdate.animation = .fly
//        camUpdate.animationDuration = 5
//        mapView.moveCamera(camUpdate)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.remove(self)
        print(locationManager?.currentLatLng())
    }
    
//    init(dep_lng: Double, dep_lat: Double, dest_lng: Double, dest_lat: Double) {
//        self.bounds1.southWestLng = dep_lng
//        self.bounds1.southWestLat = dep_lat
//        self.bounds1.northEastLng = dest_lng
//        self.bounds1.northEastLat= dest_lat
//    }
    
    
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

    
    
//    func setMarker(lat: Double, lng: Double) {
//        let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng))
//        marker.iconImage = NMF_MARKER_IMAGE_GREEN
//        marker.mapView = mapView
//    }
    
    func initPath() {
        let width: CGFloat = 8
        let outlineWidth: CGFloat = 2
        
        // 단일 경로 찍기
//        if let pathOverlay = NMFPath(points: coords) {
//            pathOverlay.width = width
//            pathOverlay.outlineWidth = outlineWidth
//            pathOverlay.color = .systemPink
//            pathOverlay.outlineColor = UIColor.white
//            pathOverlay.passedColor = UIColor.gray
//            pathOverlay.passedOutlineColor = UIColor.white
//            pathOverlay.progress = 0.3
//            pathOverlay.mapView = mapView
//            progressPathOverlay = pathOverlay
//        }
        
        // 경유지 포함 경로 찍기
        if let lineString = self.stringCoords as? [NMGLineString<AnyObject>], let multipartPathOverlay = NMFMultipartPath(lineString) {
            multipartPathOverlay.colorParts = MultiPartData.colors1
            multipartPathOverlay.width = width
            multipartPathOverlay.outlineWidth = outlineWidth
            multipartPathOverlay.mapView = mapView
            progressMultipartPath = multipartPathOverlay
        }
        
    }
    
    @objc func findPath() {
        print("touched")
        wayPointIdx.removeAll()
        coords.removeAll()
        stringCoords.removeAll()
        
        dataManager.shortestPath(depLng: bounds1.southWestLng, depLat: bounds1.southWestLat, destLng: bounds1.northEastLng, destLat: bounds1.northEastLat, wayPoints: "127.15238,37.55484|127.20376,37.62344", option: "trafast")
        
    }
}

extension ViewController: NMFLocationManagerDelegate {

}

extension ViewController: ViewControllerDelegate{
    func didSuccessReturnPath(result: Trafast){
        // 경유지 인덱스 반환
        
        for i in result.guide {
            if i.instructions == "경유지" {
                wayPointIdx.append(i.pointIndex)
            }
        }
        
        print(wayPointIdx)
        
        for i in 0..<result.path.count {
            coords.append(NMGLatLng(lat: result.path[i][1], lng: result.path[i][0]))
            
            for s in wayPointIdx {
                if i == s {
                    print("경유지")
                    stringCoords.append(NMGLineString(points: coords))
                    coords.removeAll()
                    break
                }
            }
        }
        stringCoords.append(NMGLineString(points: coords)) // 마지막까지의 경로
        
        
//        CoordsData.coords = CoordsData.coords.dropFirst()
        initPath()
        
        distanceLabel.text = "이동거리: \(result.summary.distance / 1000)km"
        
        let milliseconds = result.summary.duration
        let hours = ((milliseconds / (1000*60*60)) % 24)
        let mins = ((milliseconds / (1000*60)) % 60)
        timeLabel.text = "이동시간: \(hours)시간 \(mins)분"
        
        let camUpdate = NMFCameraUpdate(fit: bounds1, padding: 24)
        camUpdate.animation = .fly
        camUpdate.animationDuration = 5
        mapView.moveCamera(camUpdate)
    }
    func failedToRequest(message: String){
        print(message)
    }
}


struct MultiPartData {
    static let colors1: [NMFPathColor] = [
        NMFPathColor(color: UIColor.red, outlineColor: UIColor.white, passedColor: UIColor.gray, passedOutlineColor: UIColor.white),
        NMFPathColor(color: UIColor.yellow, outlineColor: UIColor.white, passedColor: UIColor.gray, passedOutlineColor: UIColor.white),
        NMFPathColor(color: UIColor.green, outlineColor: UIColor.white, passedColor: UIColor.gray, passedOutlineColor: UIColor.white),
    ]
}
