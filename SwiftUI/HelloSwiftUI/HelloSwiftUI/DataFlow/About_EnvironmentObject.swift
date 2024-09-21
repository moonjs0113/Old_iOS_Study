//
//  About_EnvironmentObject.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

// Environment: System 공유 데이터
// EnvironmentObject: Custom 공유 데이터

struct AboutEnvironmentObject: View {
    @Environment(\.colorScheme) var currentColorScheme
    @State private var value: String = ""
    @EnvironmentObject var viewModel: ObservableViewModel
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Color Scheme")
                    Spacer()
                    Text(self.currentColorScheme == .dark ? "Dark Mode" : "Light Mode")
                }
            }
            VStack {
                Text("Hello")
                    .font(.largeTitle)
                
                Button {
                    
                } label: {
                    Text("Update Title")
                }
                .padding()
                
                
                TextField("Value", text: $value)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button {
                    viewModel.list.insert(value, at: 0)
                    value = ""
                } label: {
                    Text("Add To List")
                }
                .padding()
                
                List(viewModel.list, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}

struct AboutEnvironmentObjectModifier: View {
    var body: some View {
        AboutEnvironmentObject()
            .environmentObject(ObservableViewModel())
    }
}

struct About_EnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        AboutEnvironmentObject()
    }
}
