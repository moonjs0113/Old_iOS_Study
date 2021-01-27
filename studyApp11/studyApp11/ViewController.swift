//
//  ViewController.swift
//  studyApp11
//
//  Created by 문종식 on 2020/01/24.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var startDestinationItem: MKMapItem?
    var endDestinationItem: MKMapItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // desiredAccuracy -> 정확도, kCLLocationAccuracyBest: 최고 정확도
        locationManager.requestWhenInUseAuthorization() // 위치 정보 사용자 승인 요청
        //locationManager.startUpdatingLocation() // 위치 업데이트 시작
        mapView.showsUserLocation = true // 사용자의 현재위치 표시
    
        setStartDestination(latitudeValue: 37.581706, longitudeValue: 127.074234)

    }
    
    func setStartDestination(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees){
        startDestinationItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue), addressDictionary: nil))
    }
    
    func setEndDestination(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees){
        endDestinationItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue), addressDictionary: nil))
    }
    
    // 길 찾기 요청
    func getDirections() {
        let request = MKDirections.Request()
        //request.source = MKMapItem.forCurrentLocation()
        request.source = startDestinationItem!
        request.destination = endDestinationItem!
        request.requestsAlternateRoutes = false
        request.transportType = .walking
        
        let directions = MKDirections(request: request)

        directions.calculate(completionHandler: {( response: MKDirections.Response!, error: Error!) in
            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response: response)
            }
        })
    }
    
    // 경로에 대한 도형을 맵 뷰 위에 추가하고 턴바이턴 경로를 콘솔에 출력
    func showRoute(response: MKDirections.Response) {
        // MKRoute 객체들을 반복해서 가져와서 맵 뷰의 레이어로 polyline을 추가한다.
        for route in response.routes as [MKRoute] {
            mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            // 턴바이턴 경로 출력(경로의 각 구간에 대한 텍스트 안내)
//            for step in route.steps {
//                print(step.instructions)
//            }
        }
        
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    
    // 원하는 위치로 이동하고, 핀설치
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D{
        // 위도/경도 값을 매개변수로 줌 ( latitudeValue, longitudeValue )
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle: String){
        let annotation = MKPointAnnotation() // 핀 설치를 위해
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func goBtn(_ sender: UIButton) {
        setAnnotation(latitudeValue: 37.581706, longitudeValue: 127.074234, delta: 0.01, title: "휘경현대베스트빌아파트", subtitle: "서울특별시 동대문구 휘경동 52")
    }
    
    
    @IBAction func goKonkukUniv(_ sender: UIButton) {
        if !mapView.overlays.isEmpty {
            mapView.removeOverlay(mapView.overlays[0])
        }
        setEndDestination(latitudeValue: 37.542354, longitudeValue: 127.079833)
        getDirections()
    }
    
    @IBAction func goLGCNS(_ sender: UIButton) {
        mapView.removeOverlay(mapView.overlays[0])
        setEndDestination(latitudeValue: 37.562570, longitudeValue: 126.834881)
        getDirections()
    }
    

} 

