//
//  About_Popover.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

// Popover
// iOS에서는 Card Modal로 나타난다.
// iPadOS에서는 Popup 형태(iOS의 Menu 형태)로 나타난다.
// 화면 전체를 차지하기에는 적합하지 않은 View 형태일때 사용한다.
struct AboutPopover: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Pop Over")
        }
        .padding()
        // 보통은 attachmentAnchor와 arrowEdge는 기본값을 사용한다.
//        .popover(isPresented: <#T##Binding<Bool>#>, // Presented Value
//        or
//        .popover(item: <#T##Binding<Identifiable?>#>, // item이 nil이 아닐 때
//                 attachmentAnchor: <#T##PopoverAttachmentAnchor#>, // 특정 프레임이나 좌표 전달
//                                   .rect(Anchor<CGRect>.Source.bounds) // 프레임 전체
//                 arrowEdge: <#T##Edge#>, // MacOS에서 Popover 위치를 잡는다. iOS에서는 알아서 설정해준다.
//                 content: <#T##(Identifiable) -> View#>)
    }
}

struct About_Popover_Previews: PreviewProvider {
    static var previews: some View {
        AboutPopover()
    }
}
