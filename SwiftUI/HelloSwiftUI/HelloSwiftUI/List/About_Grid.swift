//
//  About_Grid.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutGrid: View {
    var items = AppleProduct.sampleList
    
    //GridItem 속성을 잘 활용하자.
    private let columns = [
        GridItem(.adaptive(minimum: 200, maximum: .infinity), spacing: 15, alignment: .top),
//        GridItem(.flexible(minimum: 100, maximum: 300)),
//        GridItem(.fixed(100), spacing: nil, alignment: nil),
    ]
    
    private let rows = [
        GridItem(.adaptive(minimum: 150, maximum: .infinity), alignment: .leading),
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: self.columns) {
                    ForEach(items) { item in
                        ProductGridItem(product: item)
                    }
                }
                .padding()
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: self.rows, spacing: 10) {
                    ForEach(items) { item in
                        ProductGridItem(product: item)
                    }
                }
                .padding()
            }
        }
        
    }
}

struct About_Grid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutGrid()
            AboutGrid()
.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
