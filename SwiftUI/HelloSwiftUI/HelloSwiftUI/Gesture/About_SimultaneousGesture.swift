//
//  About_SimultaneousGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutSimultaneousGesture: View {
    @ObservedObject var rotation = Rotation()
    @ObservedObject var magnification = Magnification()
    
    var gestures: some Gesture {
        SimultaneousGesture(rotation.gesture,
                            magnification.gesture)
    }
    
    var body: some View {
        Image("CodeScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(self.rotation.finalAngle)
            .scaleEffect(self.magnification.finalScale)
//            .gesture(self.rotation.gesture.simultaneously(with: self.magnification.gesture))
            .gesture(gestures)
//            .gesture(self.magnification.gesture)
    }
}

struct About_SimultaneousGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutSimultaneousGesture()
    }
}


class Magnification: ObservableObject {
    private var latestScale: CGFloat = 1.0
    @Published var finalScale: CGFloat = 1.0
    
    var gesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let delta = value / self.latestScale
                self.latestScale = value
                
                self.finalScale *= delta
            }
            .onEnded { value in
                self.latestScale = 1.0
            }
    }
}


class Rotation: ObservableObject {
    var latestAngle: Angle = .degrees(0)
    @Published var finalAngle: Angle = .degrees(0)
    
    var gesture: some Gesture {
        RotationGesture()
            .onChanged { value in
                let delta = value - self.latestAngle
                self.latestAngle = value
                
                self.finalAngle = self.finalAngle + delta
            }
            .onEnded { value in
                self.latestAngle = .degrees(0)
            }
    }
}

class LongPress: ObservableObject {
    @Published var activated = false
    
    var gesture: some Gesture {
        LongPressGesture()
            .onChanged { _ in self.activated = false }
            .onEnded { _ in self.activated = true }
    }
}

class Drag: ObservableObject {
    @Published var currentTranslation = CGSize.zero
    @Published var totalTranslation = CGSize.zero
    @Published var activated = false
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                self.currentTranslation = value.translation
                self.activated = true
            }
            .onEnded { value in
                self.activated = false
                self.currentTranslation = .zero
                self.totalTranslation.width += value.translation.width
                self.totalTranslation.height += value.translation.height
            }
    }
}

enum GestureType {
    case rotation
    case magnification
}
