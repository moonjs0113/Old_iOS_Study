//
//  ViewController.swift
//  studyApp10
//
//  Created by 문종식 on 2020/01/22.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import NMapsMap
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, MTMapViewDelegate {
    
    @IBOutlet var naverView: UIView!
    @IBOutlet var kakaoView: UIView!
    //var naverMapView: NMFMapView!
    //var kakaoMapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Kakao
        let kakaoMapView = MTMapView(frame: kakaoView.bounds)
        kakaoMapView.delegate = self
        kakaoMapView.baseMapType = MTMapType.standard
        kakaoView.addSubview(kakaoMapView)
        //kakaoMarkers(kakaoMapView)
        
        // Naver
        //let naverMapView = NMFMapView(frame: naverView.frame)
        //naverPath(naverMapView)
        //naverView.addSubview(naverMapView)
        //print("###### Debug ######")
        //print(naverView.classForCoder)
        //print("###### Debug ######")
        
        //let naverMapView = NMFMapView(frame: naverView.frame)
        //naverView.addSubview(naverMapView)
    }
    
    // 네이버 API
    func requestStaticMap(){
        let client_id = "7fp6ljv1lv"
        let client_secret = "ORrwGerniDoUS3k0Ok7UHMIPspmfCOclGhvORF7r"
        // 그냥 호출
        //let url = "https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=300&h=300&center=127.1054221,37.3591614&level=16"
        // 마커(markers) 호출
        let url2 = "https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=300&h=300&markers=pos:127.1054221%2037.3591614"
        let httpHeaders: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID":client_id, "X-NCP-APIGW-API-KEY":client_secret]
        
        let DirectoryURL = URL(fileURLWithPath: "/Users/moonjs/Swift/studyApp10/staticMap.png")
        
        
        AF.request(url2,method: .get, headers: httpHeaders).response { response in
            let statusCode = response.response?.statusCode
            debugPrint(response)
            debugPrint(statusCode as Any)
            if statusCode == 200 {
                do {
                    try response.data?.write(to: DirectoryURL)
                    //debugPrint(response)
                } catch let error as NSError {
                    debugPrint("Error: \(error)")
                }
            }
        }
    }
    
    func requestGeocode(){
        let client_id = "7fp6ljv1lv"
        let client_secret = "ORrwGerniDoUS3k0Ok7UHMIPspmfCOclGhvORF7r"
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=광진구 능동로 120"
        //let url2 = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=분당구 불정로 6"
        
        // URL에 한글이 있어서 작업을 더 해줘야함
        let convertURL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        let httpHeaders: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID":client_id, "X-NCP-APIGW-API-KEY":client_secret]
        
        AF.request(convertURL, method: .get, headers: httpHeaders).response { response in
            let statusCode = response.response?.statusCode
            debugPrint(response)
            debugPrint(statusCode as Any)
            if statusCode == 200 {
                do {
                    let json = try JSON(data: response.data!)
                    print("##### Data #########")
                    print(json)
                    print("##### Data End #####")
                } catch let error as NSError {
                    debugPrint("Error: \(error)")
                }
            }
        }
    }
    
    func requestReverseGeocode(){
        let client_id = "7fp6ljv1lv"
        let client_secret = "ORrwGerniDoUS3k0Ok7UHMIPspmfCOclGhvORF7r"
        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=129.1133567,35.2982640&sourcecrs=epsg:4326&output=json&orders=addr,admcode,roadaddr"
        
        let httpHeaders: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID":client_id, "X-NCP-APIGW-API-KEY":client_secret]
        
        AF.request(url, method: .get, headers: httpHeaders).response { response in
            let statusCode = response.response?.statusCode
            debugPrint(response)
            debugPrint(statusCode as Any)
            if statusCode == 200 {
                do {
                    let json = try JSON(data: response.data!)
                    print("##### Data #########")
                    print(json)
                    print("##### Data End #####")
                } catch let error as NSError {
                    debugPrint("Error: \(error)")
                }
            }
        }
    }
    
    func requestReverseGeocode2(){
        
        let url = "https://map.kakao.com/"
        
        AF.request(url, method: .get).response { response in
            let statusCode = response.response?.statusCode
            debugPrint(response)
            debugPrint(statusCode as Any)
        }
    }
    
    func naverPath(_ mapView: Any){
        let p1 = NMGLatLng(lat: 37.57152, lng: 126.97714)
        let p2 = NMGLatLng(lat: 37.56607, lng: 126.98268)
        let p3 = NMGLatLng(lat: 37.56445, lng: 126.97707)
        let p4 = NMGLatLng(lat: 37.55855, lng: 126.97822)
        
        let path = NMFPath(points: [p1,p2,p3,p4])
        path?.mapView = mapView as? NMFMapView
    }
    
    // Kakao API
    func kakaoMarkers(_ mapView:MTMapView){
        let poiItem1 = MTMapPOIItem()
        poiItem1.itemName = "City on a Hill"
        poiItem1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.541889, longitude: 127.095388))
        poiItem1.markerType = MTMapPOIItemMarkerType.redPin
        poiItem1.showAnimationType = MTMapPOIItemShowAnimationType.dropFromHeaven
        poiItem1.draggable = true
        poiItem1.tag = 153
        let customCalloutBalloonViewIlshinBuilding = Bundle.main.loadNibNamed("CustomCalloutBalloonView_IlshinBuilding", owner: self, options: nil)?.last as? UIView
        poiItem1.customCalloutBalloonView = customCalloutBalloonViewIlshinBuilding
        mapView.addPOIItems([poiItem1])
        mapView.fitAreaToShowAllPOIItems()
    }
    
    @IBAction func staticMap(_ sender: UIButton) {
        requestStaticMap()
    }
    @IBAction func GeoCode(_ sender: UIButton) {
        requestGeocode()
    }
    @IBAction func reverseGeoCode(_ sender: UIButton) {
        requestReverseGeocode()
    }
}

