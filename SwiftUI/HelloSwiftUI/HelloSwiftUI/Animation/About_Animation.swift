//
//  About_Animation.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutAnimation: View {
    @State private var position = CGPoint.zero
    @State private var redPosition = CGPoint(x: 300, y: 0)
    @State private var animation = Animation.default
    let animationList: [Animation] = [
        .default,
        .easeIn,
        .easeInOut,
        .linear,
        .easeOut,
        .interactiveSpring(),
        .spring(),
        .interpolatingSpring(mass: 0.9, stiffness: 0.5, damping: 1, initialVelocity: 2)
    ]
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50)
                    .position(self.position)
                    .offset(x: 50, y: 50)
                    .animation(self.animation, value: position)
                
                Circle()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
                    .position(self.redPosition)
                    .offset(x: 50, y: 50)
                    .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.4), value: position)
            }
            
            Spacer()
            
            Button("Animate") {
                self.position = (self.position == .zero) ? CGPoint(x: 300, y: 500) : .zero
                self.redPosition = (self.redPosition == CGPoint(x: 300, y: 0)) ? CGPoint(x: 0, y: 500) : CGPoint(x: 300, y: 0)
            }
            .padding()
            
            Button("Random animation") {
                if let animation = self.animationList.randomElement() {
                    self.animation = animation
                }
            }
        }
    }
}

struct About_Animation_Previews: PreviewProvider {
    static var previews: some View {
        AboutAnimation()
    }
}
