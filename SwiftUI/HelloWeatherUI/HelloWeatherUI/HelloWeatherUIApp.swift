//
//  HelloWeatherUIApp.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

@main
struct HelloWeatherUIApp: App {
    let service = WeatherService()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
                .environmentObject(service)
        }
    }
}
