//
//  HelloWeatherUIWidget.swift
//  HelloWeatherUIWidget
//
//  Created by Moon Jongseek on 2022/07/04.
//

import WidgetKit
import SwiftUI



@main
struct HelloWeatherUIWidget: Widget {
    let kind: String = "HelloWeatherUIWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherEntryView(entry: entry)
        }
        .configurationDisplayName("날씨 위젯")
        .description("현재 날씨를 확인할 수 있을까요?")
        // 위젯 크기 설정
//        .supportedFamilies([.systemSmall])//,.systemLarge,.systemMedium, .systemExtraLarge])
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}

struct HelloWeatherUIWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntryView(entry: WeatherEntry(widgetData: .preview))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
