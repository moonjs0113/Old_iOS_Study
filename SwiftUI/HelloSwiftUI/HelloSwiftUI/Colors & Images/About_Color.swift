//
//  About_Color.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutColor: View {
    var body: some View {
        VStack {
            Color.green.opacity(0.5)
            Color.yellow
            Color.blue
            Color(.displayP3, red: 0.3, green: 0.1, blue: 0.6, opacity: 0.8)
            Color(.sRGB, red: 0.3, green: 0.1, blue: 0.6, opacity: 0.8)
            Color(.sRGBLinear, red: 0.3, green: 0.1, blue: 0.6, opacity: 0.8)
        }
    }
}

struct About_Color_Previews: PreviewProvider {
    static var previews: some View {
        AboutColor()
    }
}
