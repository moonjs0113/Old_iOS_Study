//
//  ContentView.swift
//  JJWebView
//
//  Created by Moon Jongseek on 2022/04/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination:
                                    MyWebView(urlString: "https://www.naver.com")
                        .edgesIgnoringSafeArea(.all)
                    ) {
                        LinkTitleView(title: "네이버", backgroundColor: .green)
                    }
                    
                    NavigationLink(destination:
                                    MyWebView(urlString: "https://www.daum.net")
                        .edgesIgnoringSafeArea(.all)
                    ) {
                        LinkTitleView(title: "다음", backgroundColor: .orange)
                    }
                    
                    NavigationLink(destination:
                                    MyWebView(urlString: "https://www.google.com")
                        .edgesIgnoringSafeArea(.all)
                    ) {
                        LinkTitleView(title: "구글", backgroundColor: .blue)
                    }
                }
                VStack(alignment: .leading) {
                    Text("asdf")
                        .frame(alignment: .center)
                    Text("asdfasdfasdf")
                }
            }
        }
    }
}

struct LinkTitleView: View {
    var title: String
    var backgroundColor: Color
    
    var body: some View {
        Text(self.title)
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(20)
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
