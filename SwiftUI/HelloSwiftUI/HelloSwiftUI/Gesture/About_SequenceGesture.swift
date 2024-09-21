//
//  About_SequenceGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutSequenceGesture: View {
    @ObservedObject var longPress = LongPress()
    @ObservedObject var drag = Drag()
    
    // 따로 뺄 수도 있다.
    var sequence: some Gesture {
        SequenceGesture(self.longPress.gesture, self.drag.gesture)
            .onEnded { _ in
                longPress.activated = false
//                 여기서 앞의 Gesture의 Activated 상태를 꺼주는게 좋다.
            }
    }
    
    var body: some View {
        Image("CodeScreen")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(drag.currentTranslation)
            .offset(drag.totalTranslation)
            .gesture(longPress.gesture.sequenced(before: drag.gesture).onEnded { _ in
                longPress.activated = false
            })
        
        // Gesture Modifier
        // Gesture를 연달아 놓을 수 있다.
        // ex) Long Press -> Drag
//            .sequenced(before: <#T##Gesture#>)
    }
}

struct About_SequenceGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutSequenceGesture()
    }
}
