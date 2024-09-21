//
//  About_Materials.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutMaterials: View {
    var body: some View {
        ZStack {
            Image("CodeScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.ultraThinMaterial)
                
                
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.thinMaterial)
                
                
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.regularMaterial)
                
                
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.thickMaterial)
                
                
                Text("Lorem Ipsum")
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.ultraThickMaterial)
                
            }
            .font(.largeTitle)
        }
    }
}

struct About_Materials_Previews: PreviewProvider {
    static var previews: some View {
        AboutMaterials()
    }
}
