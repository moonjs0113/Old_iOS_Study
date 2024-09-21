//
//  WeatherEntryView.swift
//  HelloWeatherUIWidgetExtension
//
//  Created by Moon Jongseek on 2022/07/05.
//

import SwiftUI

struct WeatherEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            
//            LottieView(fileName: "flatfish.json", animationSpeed: 1)
            LinearGradient(colors: [
                Color(red: 4/255, green: 7/255, blue: 24/255),
                Color(red: 39/255, green: 54/255, blue: 80/255)
            ], startPoint: .topTrailing, endPoint: .bottomLeading)
            
            VStack(alignment: .leading) {
                Text(entry.widgetData.lcoation)
                Text(entry.widgetData.temperatrue)
                    .font(.largeTitle)
                
                Spacer()
                
                Image(systemName: entry.widgetData.icon)
                    .symbolRenderingMode(.multicolor)
                    .font(.subheadline)
                Text(entry.widgetData.weather)
                    .font(.subheadline)
                Text("최고:\(entry.widgetData.maxTemperature)  최저:\(entry.widgetData.minTemperature)")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct WeatherEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntryView(entry: .init(widgetData: .preview))
    }
}
