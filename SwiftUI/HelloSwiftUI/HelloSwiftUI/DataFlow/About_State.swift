//
//  About_State.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutState: View {
    // 구조체에 속한 속성이지만,
    // 메모리에 저장되는 공간이 구조체와 분리된다.
    @State private var text: String = "Hello, SwiftUI"
    
    var body: some View {
        VStack(spacing: 70) {
            Text(text)
                .font(.largeTitle)
            Button {
                text = "Hi, SwitUI"
            } label: {
                Text("Update")
            }
            .padding()
        }
    }
}

struct About_State_Previews: PreviewProvider {
    static var previews: some View {
        AboutState()
    }
}
