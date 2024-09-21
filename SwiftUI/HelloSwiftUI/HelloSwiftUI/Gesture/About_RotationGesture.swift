//
//  About_Rotation.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutRotationGesture: View {
    @State private var finalAngle: Angle = .degrees(0)
    @State private var latestAngle: Angle = .degrees(0)
    
    var rotation: some Gesture {
        RotationGesture()
            .onChanged { angle in
                let delta = angle - latestAngle
                latestAngle = angle
                finalAngle += delta
            }
            .onEnded { _ in
                latestAngle = .degrees(0)
            }
    }
    
    var body: some View {
        Image("CodeScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(self.finalAngle)
            .gesture(self.rotation)
    }
}

struct About_Rotation_Previews: PreviewProvider {
    static var previews: some View {
        AboutRotationGesture()
    }
}
