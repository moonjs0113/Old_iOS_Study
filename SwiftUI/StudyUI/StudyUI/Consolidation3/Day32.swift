//
//  Day32.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/06.
//

import SwiftUI

struct Day32: View {
    @State private var animationAmount32 = 1.0
    @State private var animationAmount = 1.0
    @State private var animationAmount3D = 1.0
    @State private var enabled = false
    
    var body: some View {
        print(self.animationAmount)
        
        return VStack(spacing: 5) {
            Stepper("Scale amount", value: self.$animationAmount.animation(
                .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
            NavigationLink("Day33", destination: Day33())
            
            Spacer(minLength: 15)
            
            Button("Tap Me") {
                self.enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(self.enabled ? .yellow : .green)
            .animation(.default, value: self.enabled)
//            .animation(nil, value: self.enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: self.enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: self.enabled)
            
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)){
                    self.animationAmount3D += 360
                }
            }
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
//            .scaleEffect(self.animationAmount3D)
            .rotation3DEffect(.degrees(self.animationAmount3D),
                              axis: (x: 0, y: 1, z: 0))
            
            Button("Tap Me") {
    //            self.animationAmount += 0.1
            }
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
    //        .scaleEffect(self.animationAmount)
    //        .animation(.default, value: self.animationAmount)
    //        .animation(.easeOut, value: self.animationAmount)
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(self.animationAmount32)
                    .opacity(2 - self.animationAmount32)
                    .animation(
                        .easeInOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: self.animationAmount32)
            )
            .onAppear {
                self.animationAmount32 = 1.5
            }
    //        .animation(.easeOut(duration: 1)
    //                    .delay(1)
    //                    .repeatCount(3, autoreverses: true),
    //                   value: self.animationAmount)
    //        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: self.animationAmount)
    //        .blur(radius: (self.animationAmount - 1) * 3)
        }
    }
}

struct Day32_Previews: PreviewProvider {
    static var previews: some View {
        Day32()
    }
}
