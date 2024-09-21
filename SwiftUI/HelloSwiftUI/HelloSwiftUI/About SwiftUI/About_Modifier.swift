//
//  About_Modifier.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutModifier: View {
    @State private var data: String = "0"
    
    var body: some View {
        VStack {
            Text(self.data)
                .padding(2)
                .background(.white)
                .padding(5)
                .background(.yellow)
                .padding(5)
                .background(.cyan)
            
            Button {
                data = "\(Int.random(in: Int.min...Int.max))"
            } label: {
                Text("Update")
            }
            .padding()
            .font(.largeTitle)
            // Modifier는 가장 가까운 것으로 적용된다.
        }
        .padding()
        .font(.caption)
        .onAppear {
            
        }
        .onDisappear {
            
        }
    }
}

struct AboutModifier_Previews: PreviewProvider {
    static var previews: some View {
        AboutModifier()
    }
}
