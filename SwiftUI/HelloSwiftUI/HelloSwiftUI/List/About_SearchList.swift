//
//  About_SearchList.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutSearchList: View {
    @State private var keyword = ""
    @State private var items = AppleProduct.sampleList
    
    var body: some View {
        NavigationView {
            List(items) { item in
                Text(item.name)
            }
            // .navigationBarDrawer(displayMode: .always)
            // iOS 전용
            // Memoji Collector에 추가
            .searchable(text: self.$keyword, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색어를 입력하세요.") {
                
//                Text("Mac").searchCompletion("Mac")
//                Label("MacBook", systemImage: "laptopcomputer").searchCompletion("MacBook")
            }
            .onChange(of: keyword) { newValue in
                // Cancel 쓰는 법
                if newValue.count == 0 {
                    items = AppleProduct.sampleList
                }
//                if newValue.count > 0 {
//                    items = AppleProduct.sampleList.filter {
//                        $0.name.contains(newValue)
//                    }
//                } else {
//                    items = AppleProduct.sampleList
//                }
            }
            .onSubmit(of: .search) {
                if keyword.count > 0 {
                    items = AppleProduct.sampleList.filter {
                        $0.name.contains(keyword)
                    }
                } else {
                    items = AppleProduct.sampleList
                }
            }
        }
    }
}

struct About_SearchList_Previews: PreviewProvider {
    static var previews: some View {
        AboutSearchList()
    }
}
