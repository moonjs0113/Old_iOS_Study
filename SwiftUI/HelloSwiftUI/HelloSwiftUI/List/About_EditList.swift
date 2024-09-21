//
//  About_EditList.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutEditList: View {
    @State private var items = AppleProduct.sampleList
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(items) {item in
                        Text(item.name)
                    }
                    .onDelete { rows in
                        items.remove(atOffsets: rows)
                    }
//                    .onMove { indexSet, int in
//                        items.move(fromOffsets: indexSet, toOffset: int)
//                    }
                    .onMove(perform: move)
                }
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func move(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct About_EditList_Previews: PreviewProvider {
    static var previews: some View {
        AboutEditList()
    }
}
