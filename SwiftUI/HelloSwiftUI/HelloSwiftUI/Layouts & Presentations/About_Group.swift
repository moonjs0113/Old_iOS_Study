//
//  About_Group.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutGroup: View {
    var body: some View {
        VStack {
            // Group
            // - 논리적으로 묶는 역할을 한다.
            // - 같은 Modifier를 묶어서 사용할 수도 있다.
            // - Stack으로 묶는 것보다 좋다.
            // - Layout에는 보통 영향을 주지 않는다.
            // - Group 안의 View도 Stack의 Spacing 적용을 받는다.
            Group {
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
                Text("Group")
            }
            .font(.title3)
            .padding(1)
            
            VStack {
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
                Text("VStack")
            }
            .padding(1)
        }
    }
}

struct About_Group_Previews: PreviewProvider {
    static var previews: some View {
        AboutGroup()
    }
}
