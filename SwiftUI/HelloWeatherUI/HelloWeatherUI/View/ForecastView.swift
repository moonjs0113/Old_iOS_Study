//
//  ForecastView.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var service: WeatherService
    
    var body: some View {
        ForEach(self.service.forecastList ?? []) { forecast in
            HStack {
                VStack(alignment: .leading) {
                    Text(forecast.date)
                    Text(forecast.time)
                }
                .font(.caption)
                
                Spacer()
                
                Image(systemName: forecast.icon)
                    .symbolRenderingMode(.multicolor)
                    .font(.title3)
                
                Text(forecast.weather)
                    .font(.title3)
                
                Spacer()
                
                Text(forecast.temperature)
                    .font(.system(size: 40))
                    .fontWeight(.ultraLight)
                    .frame(minWidth: 70, alignment: .trailing)
                
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
