//
//  MyWebView.swift
//  JJWebView
//
//  Created by Moon Jongseek on 2022/04/14.
//

import SwiftUI
import WebKit

// UIView -> UIViewRepresentable
// UIViewController -> UIViewControllerRepresentable
struct MyWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var urlString: String
    
    // 만들어질 View
    func makeUIView(context: Context) -> UIViewType {
        let webView = WKWebView()
        if let url = URL(string: self.urlString) {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    // SwiftUI에서 View를 다시 그리기 위해 호출되는 함수
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<MyWebView>) {
        
    }
}

struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        MyWebView(urlString: "https://www.naver.com")
    }
}
