//
//  About_SelectionList.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutSelectionList: View {
    var items = AppleProduct.sampleList
//    var multiItems = AppleProduct.sampleList
    
    @State private var selected: AppleProduct? = nil
    @State private var multiSelected: Set<AppleProduct> = []
    @State private var multiCheckSelected: Set<AppleProduct> = []
    
    var body: some View {
        VStack {
            HStack{
                NavigationView {
                    VStack {
                        Text("Selected: \(selected?.name ?? "-")")
                            .font(.title)
                        
                        //            List(items, selection: self.$selected) { item in
        //                            List(items) { item in
                        List(items, id: \.self, selection: self.$selected) { item in
                            Button {
                                //                    selected = item
                            } label: {
                                Text(item.name)
                            }
                        }
                    }
                    .toolbar {
                        // EditButton을 사용하려면 List의 selection Parameter를 줘야한다.
                        EditButton()
                    }
                }
                NavigationView {
                    VStack {
                        Text("\(multiSelected.count) item(s) selected")
                            .font(.title)
                        
                        List(items, id: \.self, selection: self.$multiSelected) { item in
                            Text(item.name)
                        }
                    }
                    .toolbar {
                        EditButton()
                    }
                }
            }
            NavigationView {
                VStack {
                    Text("\(multiCheckSelected.count) item(s) selected")
                        .font(.title)
                    
                    List(items, id: \.self, selection: self.$multiCheckSelected) { item in
                        Button {
                            if multiCheckSelected.contains(item) {
                                multiCheckSelected.remove(item)
                            } else {
                                multiCheckSelected.insert(item)
                            }
                        } label: {
                            if multiCheckSelected.contains(item) {
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                }
                            } else {
                                Text(item.name)
                            }
                        }
                    }
                }
                .toolbar {
                    EditButton()
                }
            }
        }
    }
}

struct About_SelectionList_Previews: PreviewProvider {
    static var previews: some View {
        AboutSelectionList()
    }
}
