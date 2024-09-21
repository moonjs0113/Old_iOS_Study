//
//  ContentView.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import SwiftUI

struct ConcurrencyView: View {
    var body: some View {
        TabView {
            NetworkView()
                .tabItem {
                    Text("Network")
                }
            UIKitView()
                .tabItem {
                    Text("UIKit to SwiftUI")
                }
            SwiftUIView()
                .tabItem {
                    Text("SwiftUI to UIKit")
                }
        }
    }
}

struct ConcurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ConcurrencyView()
    }
}
