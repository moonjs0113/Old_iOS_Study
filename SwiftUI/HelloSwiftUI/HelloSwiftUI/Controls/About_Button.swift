//
//  About_Button.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutButton: View {
    var body: some View {
        Group {
            Button("automatic") {
                
            }
            .padding()
            .buttonStyle(.automatic)
            
            Button("bordered") {
                
            }
            .padding()
            .buttonStyle(.bordered)
            
            Button("borderedProminent") {
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Button("borderedProminent capsule") {
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            
            Button("borderedProminent roundedRectangle") {
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            
            Button("borderedProminent roundedRectangle radius 0") {
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 0))
            
            Button("borderedProminent automatic") {
                
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.automatic)
            
            Button("borderless") {
                
            }
            .padding()
            .buttonStyle(.borderless)
            
            Button("plain") {
                
            }
            .padding()
            .buttonStyle(.plain)
        }
        .tint(.yellow)
    }
}

struct About_Button_Previews: PreviewProvider {
    static var previews: some View {
        AboutButton()
    }
}
