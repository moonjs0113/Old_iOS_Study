//
//  About_ObservableObject.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

class ObservableViewModel: ObservableObject {
    var title = "Hello"
    @Published var list = [String]()
    @Published var text = "Text"
    
    init() {
        
    }
    
    init(title: String) {
        self.title = title
    }
}

class ViewModel {
    var title = "Hello"
    @Published var list = [String]()
    
    init() {
        
    }
    
    init(title: String) {
        self.title = title
    }
}

struct AboutObservableObject: View {
    @State private var value: String = ""
    @State private var stateValue: String = ""
    @State private var normalValue: String = ""
    
    // ObservedObject, StateObject는 객체 자체를 mutating할 수 없다.
    @ObservedObject private var viewModel = ObservableViewModel()
    
    // ObservableObject Class에 State를 쓸 수는 있다.
    // 객체 자체를 바꿔야하는 경우에는 쓰이는 듯 하다. -> 이런 경우가 있나?
    @State private var stateViewModel = ObservableViewModel(title: "State View Model")
    
    @State private var normalViewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(viewModel.title)
                        .font(.largeTitle)
                    
                   
                    Button {
                        viewModel.title = "Hi"
                    } label: {
                        Text("Update Title")
                    }
                    .padding()
                    
                    Button {
    //                    viewModel = ViewModel(title: "New ObservedObject")
                    } label: {
                        Text("Update Object")
                    }
                    
                    
                    TextField("Value", text: $value)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button {
                        viewModel.list.insert(value, at: 0)
//                        stateViewModel.list.insert(value, at: 0)
//                        normalViewModel.list.insert(value, at: 0)
//                        value = ""
                    } label: {
                        Text("Add To List")
                    }
                    .padding()
                    
                    List(viewModel.list, id: \.self) { item in
                        Text(item)
                    }
                }
                VStack {
                    Text(stateViewModel.title)
                        .font(.largeTitle)
                    
                    Button {
                        stateViewModel.title = "Hi"
                    } label: {
                        Text("Update Title")
                    }
                    
                    Button {
                        stateViewModel = ObservableViewModel(title: "New Object")
                    } label: {
                        Text("Update Object")
                    }
                    .padding()
                    
                    TextField("Value", text: $stateValue)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Button {
                        stateViewModel.list.insert(stateValue, at: 0)
//                        value = ""
                    } label: {
                        Text("Add To List")
                    }
                    .padding()
                    
                    List(stateViewModel.list, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            VStack {
                Text(normalViewModel.title)
                    .font(.largeTitle)
                
               
                Button {
                    normalViewModel.title = "Hi"
                } label: {
                    Text("Update Title")
                }
                .padding()
                
                Button {
                    normalViewModel = ViewModel(title: "New Object")
                } label: {
                    Text("Update Object")
                }
                
                Button {
                    normalViewModel.list.insert(normalValue, at: 0)
//                    normalValue = ""
                } label: {
                    Text("Add To List")
                }
                
                TextField("Value", text: $normalValue)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                List(normalViewModel.list, id: \.self) { item in
                    Text(item)
                }
            }
        }
        
    }
}

struct About_ObservableObject_Previews: PreviewProvider {
    static var previews: some View {
        AboutObservableObject()
    }
}
