//
//  About_Binding.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutBinding: View {
    // Two Way Binding
    @State private var value: String = "Hello"
    
    var body: some View {
        VStack(spacing: 70) {
            Text(value)
                .font(.largeTitle)
            
            InputView(value: $value)
        }
    }
}

struct InputView: View {
    @Binding var value: String
    
    var body: some View {
        TextField("Input", text: $value)
            .padding()
    }
}

struct About_Binding_Previews: PreviewProvider {
    static var previews: some View {
        AboutBinding()
    }
}
