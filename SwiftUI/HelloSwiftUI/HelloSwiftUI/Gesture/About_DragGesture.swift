//
//  About_DragGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutDragGesture: View {
    var dragGesture: some Gesture {
//        DragGesture(minimumDistance: 10, coordinateSpace: .global)
        
        DragGesture()
            .updating($currentTranslation) { value, state, transaction in
                // value: Gesture의 상태, .onChanged, .onEnded에서 전달되는 값
                // state: Binding Value의 입출력(IO) 파라미터
                // transaction: Gesture의 정보
                
                state = value.translation
            }
        // value가 지속되서 업데이트된다.
//            .onChanged { value in
//                print(value)
                // 터치 되는 좌표와 최종 좌표 기준점이 다름
//                currentTranslation = value.translation
//            }
        // 마지막 value
            .onEnded { endValue in
//                print(endValue)
//                currentTranslation = .zero
                print(endValue.translation)
                var t = finalTranslation
                t.width += endValue.translation.width
                t.height += endValue.translation.height
                finalTranslation = t
            }
    }
    
    // 변수 두개를 써야하는 이유
    // Drag를 시작한 최초의 좌표가 value가 된다.
    
    // 이런게 있네;
    // @GestureState
    // - Gesture가 끝나면서 기본값으로 초기화됨
    // - get-only Property가 된다.
    @GestureState private var currentTranslation: CGSize = .zero
    @State private var finalTranslation: CGSize = .zero
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.yellow)
                .frame(width: 100, height: 100)
                .offset(finalTranslation)
                .offset(self.currentTranslation)
                .gesture(self.dragGesture)
            // Drag And Drop 할 때, 쓰는 Modifier
            // 그냥 Drag랑 다름
//                .onDrag(<#T##data: () -> NSItemProvider##() -> NSItemProvider#>)
        }
    }
}

struct About_DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutDragGesture()
    }
}
