//
//  About_StateObject.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

// ObservableObject 객체 생성 -> StateObject
// ObservableObject 객체 의존성 주입 -> ObservableObject 선언

// 단순히 View의 업데이트의 문제만 있는 것은 아니다.
struct AboutStateObject: View {
    @StateObject private var stateViewModel: ObservableViewModel = ObservableViewModel()
    @ObservedObject private var observedViewModel: ObservableViewModel = ObservableViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Next", destination: WhatDifferenceObjectText())
                List(stateViewModel.list, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .environmentObject(stateViewModel)
    }
}

struct WhatDifferenceObjectText: View {
    @EnvironmentObject var viewModel: ObservableViewModel
    
    var body: some View {
        VStack {
            NavigationLink("Next", destination: WhatDifferenceObjectList())
            Text(viewModel.text)
        }
    }
}

struct WhatDifferenceObjectList: View {
    @State private var value: String = ""
    @EnvironmentObject var viewModel: ObservableViewModel
    
    var body: some View {
        VStack {
            TextField("Value", text: $value)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button {
                viewModel.list.insert(value, at: 0)
                viewModel.text = value
                value = ""
            } label: {
                Text("Add To List")
            }
            .padding()
        }
    }
}

struct About_StateObject_Previews: PreviewProvider {
    static var previews: some View {
        AboutStateObject()
    }
}
