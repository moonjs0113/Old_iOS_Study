//
//  WeatherContentView.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

struct WeatherContentView: View {
    
    @EnvironmentObject var service: WeatherService
    
    var body: some View {
        VStack {
            Text(self.service.currentLocation ?? "")
                .font(.title2)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            
            GeometryReader { reader in
                ScrollView(showsIndicators: false) {
                    VStack {
                        Color.clear
                        CurrentWeatherView(model: self.service.currentWeather)
                    }
                    .frame(height: reader.size.height)
                    
                    Spacer(minLength: reader.safeAreaInsets.bottom)
                    ForecastView()
                }
            }
        }
    }
}

struct WeatherContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherContentView()
    }
}
