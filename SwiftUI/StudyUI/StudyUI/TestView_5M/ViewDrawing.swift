//
//  ViewDrawing.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/05/19.
//

import SwiftUI

struct WrappedViewDrawing: View {
    init() {
        print("WrappedViewDrawing")
    }
    var body: some View {
        ViewDrawing()
    }
}

struct ViewDrawing: View {
    init() {
        print("init ViewDrawing View")
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ViewDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ViewDrawing()
    }
}
