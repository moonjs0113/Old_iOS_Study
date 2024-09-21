//
//  Day39_3.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/14.
//

import SwiftUI

struct Day39_3: View {
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
    ]
    
//    let layout = [
//        GridItem(.adaptive(minimum: 80)),
//    ]
        let layoutAdaptive = [
            GridItem(.adaptive(minimum: 80, maximum: 120)),
        ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyVGrid(columns: self.layout) {
                ForEach(0..<10) {
                    Text("Item \($0)")
                }
            }
            
            LazyHGrid(rows: self.layoutAdaptive) {
                ForEach(0..<10) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct Day39_3_Previews: PreviewProvider {
    static var previews: some View {
        Day39_3()
    }
}
