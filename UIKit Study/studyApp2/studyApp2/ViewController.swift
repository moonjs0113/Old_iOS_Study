//
//  ViewController.swift
//  studyApp2
//
//  Created by 문종식 on 2020/01/04.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // 8장
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var locationsInfo: UILabel!
    @IBOutlet var locationsInfo2: UILabel!
    let locationManager = CLLocationManager()
    
    // 9장
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    var images = [ "01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 8장
        locationsInfo.text = ""
        locationsInfo2.text = ""
        locationManager.delegate = self
        // desiredAccuracy -> 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 최고 정확도
        // 위치 정보 사용자 승인 요청
        print("requestWhenInUseAuthorization")
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트 시작
        print("startUpdatingLocation")
        locationManager.startUpdatingLocation()
        // 위치 보기 값
//        mapView.showsUserLocation = true
        
        // 9장
        pageControl.numberOfPages = images.count // Control 길이
        pageControl.currentPage = 0
        // 객체에서 오른쪽마우스 -> Jump to Definition 으로 가면 속성 볼 수 있음
        pageControl.pageIndicatorTintColor = UIColor.green // Control 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red // 현재 Control 색상
        imageView.image = UIImage(named: images[0])
    }

    
    // 8장
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last // 위치가 업데이트되면 먼저 마지막 위치 값을 찾아냄
        // 마지막 위치의 위/경도 값을 가지고 goLocation을 호출
        // delta -> 지도의 크기, 1/Value 배
        // _ 반환값이 있는 func을 사용할 때 반환 값 무시
        print("requestWhenInUseAuthorization")
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 100배
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            // Simulator -> Debug -> Location -> Custom Location
            let pm = placemarks!.first // placemarks의 첫 부분만 저장
            let country = pm!.country // 나라 값
            var address:String = country!
            if pm!.locality != nil{ // 지역 값이 존재하면 address에 추가
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil { // 도로 값이 존재하면 address에 추가
                address += " "
                address += pm!.thoroughfare!
            }
            self.locationsInfo.text = "현재위치"
            self.locationsInfo2.text = address
        })
        locationManager.stopUpdatingLocation() // 위치 업데이트 stop
    }
    
    // Segmented Control
    // Monentary -> 현재 선택된 값 표시 여부
    // Segment에 글자 대신 이미지를 넣을 수 있음
    // Enabled -> 선택불가
    // Selected -> 선택된 상태로 표시, 실제로 동작은 안 함. Segment 중 하나만 Selected 속성을 가질 수 있음.
    // Content Offset -> Segment 내에서 텍스트의 위치 변경 가능
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.locationsInfo.text = ""
            self.locationsInfo2.text = ""
            locationManager.startUpdatingLocation()
        } else if sender.selectedSegmentIndex == 1 {
            setAnnotation(latitudeValue: 37.542354, longitudeValue: 127.079833, delta: 0.001, title: "Konkuk Univ. 중장비동", subtitle: "서울특별시 광진구 능동로 120")
            self.locationsInfo.text = "선택된 위치: "
            self.locationsInfo2.text = "건국대학교 중장비동"
        } else if sender.selectedSegmentIndex == 2 {
            setAnnotation(latitudeValue: 37.562570, longitudeValue: 126.834881, delta: 0.001, title: "LG CNS 본사", subtitle: "서울특별시 강서구 마곡중앙8로 71 LG사이언스파크 E13")
            self.locationsInfo.text = "선택된 위치: "
            self.locationsInfo2.text = "LG CNS 본사"
        }
    }
    
    // 9장
    // pageControl의 좌우를 터치하여 이동
    @IBAction func pageControl(_ sender: UIPageControl) {
        imageView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    // 10장
    @IBAction func moveApp1View(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func moveApp0View(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

