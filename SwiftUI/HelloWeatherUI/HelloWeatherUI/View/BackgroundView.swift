//
//  BackgroundView.swift
//  HelloWeatherUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { reader in
            Image("CodeScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay{
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
