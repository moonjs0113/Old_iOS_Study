//
//  WeatherEntry.swift
//  HelloWeatherUIWidgetExtension
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation
import WidgetKit

struct WeatherEntry: TimelineEntry {
    let widgetData: WidgetData
    
    var date: Date {
        widgetData.date
    }
}
