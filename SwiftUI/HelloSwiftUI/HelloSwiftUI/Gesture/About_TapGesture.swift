//
//  About_TapGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutTapGesture: View {
    
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                print("TapGesture Property")
            }
    }
    
    var body: some View {
        VStack(spacing:  5) {
            Text("Tap Me")
                .onTapGesture {
                    print("Tap!")
                }
            
            Text("Tap Me Count 2")
                .onTapGesture(count: 2) {
                    print("Tap! 2")
                }
            
            Text("Tap Me in Gesture")
                .gesture(TapGesture().onEnded{
                    print("Me in Gesture")
                })
            
            Text("Tap Me Property")
                .gesture(self.tapGesture)
            // 하나이상의 gesture가 있을때 순서가 중요하나,
            // 앞에서 gesture가 처리되었으면 이후 gesture는 무시된다.
            // 단, 약간의 딜레이가 발생하기 때문에 되도록 하나만 쓰면 좋다.
            
        }
        
    }
}

struct About_TapGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutTapGesture()
    }
}
