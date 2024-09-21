//
//  About_Link.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutLink: View {
    let url = URL(string: "http://developer.apple.com")!
    let sms = URL(string: "sms://010-0000-0000")!
    
    var body: some View {
        Link(destination: url) {
            Label("Apple Developer", systemImage: "house")
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
        .environment(\.openURL, OpenURLAction { url in
//            <#T##(URL) -> OpenURLAction.Result#>
            if url.absoluteString.contains("Apple") {
                print("World Class Developer")
                return .handled
            } else if url.absoluteString.hasPrefix("http://") {
                var components = URLComponents(url: url,
                                               resolvingAgainstBaseURL: false)!
                components.scheme = "https"
                return .systemAction(components.url!)
            } else if url.absoluteString.contains("BadURL") {
                return .discarded
            }
            return .systemAction
        })
    }
}

struct About_Link_Previews: PreviewProvider {
    static var previews: some View {
        AboutLink()
    }
}
