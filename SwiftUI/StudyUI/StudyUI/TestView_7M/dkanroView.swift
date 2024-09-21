//
//  dkanroView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/07/04.
//

import SwiftUI

class 아무개 {
    init() {
        print("나왔어요!")
    }
}

struct 아무개_View: View {
    var 아무개class = 아무개()
    
    var body: some View {
        Text("진짜 아무개")
    }
}

struct GhostView: View {
    var body: some View {
        아무개_View()
    }
}

struct dkanroView_Previews: PreviewProvider {
    static var previews: some View {
        아무개_View()
    }
}
