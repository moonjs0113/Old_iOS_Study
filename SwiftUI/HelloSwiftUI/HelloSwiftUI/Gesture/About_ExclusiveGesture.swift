//
//  About_ExclusiveGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutExclusiveGesture: View {
    @ObservedObject var rotation = Rotation()
    @ObservedObject var magnification = Magnification()
    @State private var currentGestureType = GestureType.rotation
    
    var gesture: some Gesture {
        ExclusiveGesture(rotation.gesture, magnification.gesture)
//        if currentGestureType == .rotation {
//            ExclusiveGesture(rotation.gesture, magnification.gesture)
//        } else {
//            ExclusiveGesture(magnification.gesture, rotation.gesture)
//        }
    }
    
    var image: some View {
        Image("CodeScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var body: some View {
        VStack {
            VStack {
                if currentGestureType == .rotation {
                    image
                        .rotationEffect(rotation.finalAngle)
                        .scaleEffect(magnification.finalScale)
                        .gesture(gesture)
                } else {
                    image
                        .rotationEffect(rotation.finalAngle)
                        .scaleEffect(magnification.finalScale)
                        .gesture(magnification.gesture.exclusively(before: rotation.gesture))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ExclusiveGestureMenu(currentGestureType: $currentGestureType)
        }
    }
}

struct About_ExclusiveGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutExclusiveGesture()
    }
}

struct ExclusiveGestureMenu: View {
    @Binding var currentGestureType: GestureType
    
    var body: some View {
        HStack {
            Button {
                currentGestureType = .rotation
            } label: {
                Label("Rotation", systemImage: "arrow.2.circlepath")
                    .foregroundColor(currentGestureType == .rotation ? Color.white : Color.blue)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(currentGestureType == .rotation ? Color.blue : Color.white)
            
            Button {
                currentGestureType = .magnification
            } label: {
                Label("Magnification", systemImage: "magnifyingglass")
                    .foregroundColor(currentGestureType == .magnification ? Color.white : Color.blue)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(currentGestureType == .magnification ? Color.blue : Color.white)
        }
    }
}
