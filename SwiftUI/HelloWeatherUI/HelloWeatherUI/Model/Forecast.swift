//
//  Forecast.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

struct Forecast: Identifiable {
    var id = UUID()
    let date: String
    let time: String
    let icon: String
    let weather: String
    let temperature: String
    let minTemperature: String
    let maxTemperature: String
    let forecastedDate: Date
}

extension Forecast {
    static var preview: [Forecast] {
        return (0..<10).map {
            let dt = Date.now.addingTimeInterval(TimeInterval($0 * 3600 * 24))
            return Forecast(date: dt.formatted(.dateTime.month().day()),
                            time: dt.formatted(.dateTime.hour().minute()),
                            icon: "sun.max.fill",
                            weather: "맑음",
                            temperature: Double.randomTemperatureString,
                            minTemperature: Double.randomTemperatureString,
                            maxTemperature: Double.randomTemperatureString,
                            forecastedDate: .now)
        }
    }
    
    init?(data: CodableForecast.ListItem) {
        let dt = Date(timeIntervalSince1970: TimeInterval(data.dt))
        
        date = dt.formatted(.dateTime.month().day())
        time = dt.formatted(.dateTime.hour().minute())
        forecastedDate = dt
        
        guard let weatherData = data.weather.first else { return nil }
        
        icon = weatherData.icon.weatherImageName
        weather = weatherData.description
        
        temperature = data.main.temp.temperatureString
        maxTemperature = data.main.temp_max.temperatureString
        minTemperature = data.main.temp_min.temperatureString
    }
}
