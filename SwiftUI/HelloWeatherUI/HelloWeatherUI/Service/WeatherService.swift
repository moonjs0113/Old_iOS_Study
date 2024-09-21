//
//  WeatherService.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation
import CoreLocation

class WeatherService: NSObject, ObservableObject {
    static let apiKey = "a704b023990b8b5486ed472910d27355"
    
    let locationManager: CLLocationManager
    
    @Published var currentLocation: String?
    
    @Published var currentWeather: CurrentWeather?
    @Published var forecastList: [Forecast]?
    
    @Published var lastError: String?
    
    @Published var updating: Bool
    
    let isPreviewService: Bool
    
    init(preview: Bool = false) {
        isPreviewService = preview
        updating = false
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        super.init()
        
        locationManager.delegate = self
    }
    
    static var preview: WeatherService {
        let service = WeatherService(preview: true)
        service.currentLocation = "강남역"
        service.currentWeather = CurrentWeather.preview
        service.forecastList = Forecast.preview
        return service
    }
    
    func fetch() {
        guard !isPreviewService else { return }
        
        updating = true
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .restricted:
            lastError = "위치 서비스 사용 권한이 없습니다."
            updating = false
        default:
            lastError = "알 수 없는 오류가 발생했습니다."
            updating = false
        }
    }
}
