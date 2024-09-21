//
//  About_View.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutView: View {
    @State private var data: String = "0"
    
    // body는 반드시 하나의 View를 return해야한다.
    var body: some View {
        VStack {
            Text(self.data)
                .padding()
            
            Button {
                data = "\(Int.random(in: Int.min...Int.max))"
            } label: {
                Text("Update")
            }
        }
        .onAppear {
            
        }
        .onDisappear {
            
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
