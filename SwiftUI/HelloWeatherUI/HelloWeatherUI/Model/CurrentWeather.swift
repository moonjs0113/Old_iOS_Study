//
//  CurrentWeather.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

struct CurrentWeather {
    let icon: String
    let weather: String
    
    let temperature: String
    let maxTemperature: String
    let minTemperature: String
    
    let sunrise: String
    let sunset: String
    let forecastedDate: Date
}

extension CurrentWeather {
    static var preview: CurrentWeather {
        return CurrentWeather(icon: "sun.max.fill",
                              weather: "맑음",
                              temperature: Double.randomTemperatureString,
                              maxTemperature: Double.randomTemperatureString,
                              minTemperature: Double.randomTemperatureString,
                              sunrise: "오전 6:00",
                              sunset: "오후 6:00",
                              forecastedDate: .now)
    }
    
    init?(data: CodableCurrentWeather) {
        guard let weatherInfo = data.weather.first else { return nil }
        
        icon = weatherInfo.icon.weatherImageName
        weather = weatherInfo.description
        temperature = data.main.temp.temperatureString
        maxTemperature = data.main.temp_max.temperatureString
        minTemperature = data.main.temp_min.temperatureString
        
        var date = Date(timeIntervalSince1970: data.sys.sunrise)
        sunrise = date.formatted(.dateTime.hour().minute())
        
        date = Date(timeIntervalSince1970: data.sys.sunset)
        sunset = date.formatted(.dateTime.hour().minute())
        
        forecastedDate = Date(timeIntervalSince1970: data.dt)
    }
}
