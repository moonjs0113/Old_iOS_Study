//
//  WeatherService+API.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation
import CoreLocation

extension WeatherService {
    enum APIType: String {
        case forecast
        case weather
    }
    
    @MainActor
    func fetchWeather(location: CLLocation) async {
        do {
            async let fetchedCurrentWeather: CodableCurrentWeather = fetch(type: .weather, location: location)
            async let fetchedForecast: CodableForecast = fetch(type: .forecast, location: location)
            currentWeather = CurrentWeather(data: try await fetchedCurrentWeather)
            
            forecastList = try await fetchedForecast.list.compactMap {
                print($0)
                return Forecast(data: $0)
            }
            
        } catch(let e) {
            debugPrint(e)
            lastError = "API 요청 실패"
        }
    }
    
    func fetch<P: Codable>(type: APIType, location: CLLocation) async throws -> P {
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/\(type.rawValue)")
        components?.queryItems = [
            URLQueryItem(name: "appid", value: Self.apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "kr"),
            URLQueryItem(name: "lat", value: "\(location.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.coordinate.longitude)")
        ]
        
        guard let url = components?.url else {
            throw APIError.invalidURL(components?.host ?? "")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.failed(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(P.self, from: data)
        
        return result
    }
}
