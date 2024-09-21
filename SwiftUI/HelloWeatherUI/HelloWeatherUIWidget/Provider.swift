//
//  Provider.swift
//  HelloWeatherUIWidgetExtension
//
//  Created by Moon Jongseek on 2022/07/05.
//

import Foundation
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(widgetData: .preview)
    }

    
    // Widget 갤러리에서 Widget을 표시될 떄 호출된다.
    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        var data = WidgetData.preview
        
        if !context.isPreview { // 갤러리에 표시될 때 true가 된다.
            let list = WidgetData.read()
            if !list.isEmpty {
                data = list[0]
            }
        }
        let entry = WeatherEntry(widgetData: .preview)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let entries: [WeatherEntry] = WidgetData.read().map {
            WeatherEntry(widgetData: $0)
        }
        
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = WeatherEntry(widgetData: .preview)
//            entries.append(entry)
//        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
