//
//  MainView.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var service: WeatherService
    
    var body: some View {
        ZStack {
            BackgroundView()
            if service.updating {
                ProgressView()
            } else if let _ = service.lastError {
                ErrorView()
            } else {
                WeatherContentView()
            }
        }
        .animation(.easeIn, value: service.updating)
        .onAppear {
            self.service.fetch()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
