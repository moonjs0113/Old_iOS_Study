//
//  Abour_MagnificationGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

// Pinch Gesture

struct AbourMagnificationGesture: View {
    @State private var finalScale: CGFloat = 1.0
    @State private var latestScale: CGFloat = 1.0
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { scale in
                let delta = scale / latestScale
                latestScale = scale
                finalScale *= delta
            }
            .onEnded { value in
                latestScale = 1.0
            }
    }
    
    var body: some View {
        Image("CodeScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaleEffect(finalScale)
            .gesture(magnification)
    }
}

struct Abour_ManificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        AbourMagnificationGesture()
    }
}
