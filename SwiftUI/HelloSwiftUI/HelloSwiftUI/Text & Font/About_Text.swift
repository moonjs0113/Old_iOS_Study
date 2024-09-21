//
//  About_Text.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI



struct AboutText: View {
    let longText = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                // Text의 String 자체가 Localizable Key가 된다.
                Text("Hello, World!")
                Text(verbatim: "Hello")
                Text("Hello")
                
                Text(self.longText)
                    .lineLimit(1)
                //                .lineLimit(10)
                    .multilineTextAlignment(.center)
                    .lineSpacing(10)
            }
            Group {
                Label("User Profile", systemImage: "house.fill")
                // toolbar에선 .iconOnly이 Default
                Label("User Profile", systemImage: "house.fill")
                    .labelStyle(.iconOnly)
                Label("User Profile", systemImage: "house.fill")
                    .labelStyle(.titleOnly)
            }
        }
    }
}

struct Text_Previews: PreviewProvider {
    static var previews: some View {
        AboutText()
        // Localizable Environment Variable
            .environment(\.locale, Locale(identifier: "ko_kr"))
    }
}
