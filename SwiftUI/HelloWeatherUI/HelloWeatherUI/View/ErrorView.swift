//
//  ErrorView.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var service: WeatherService
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.circle")
                .font(.largeTitle)
            
            if let error = service.lastError {
                Text(error)
                    .padding()
            }
            
            Button {
                service.lastError = nil
                service.fetch()
            } label: {
                Text("다시 요청")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
