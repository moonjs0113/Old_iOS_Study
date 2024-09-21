//
//  About_AsyncImage.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutAsyncImage: View {
    let url = URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")
    
    var body: some View {
        VStack {
            AsyncImage(url: self.url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let _):
                    Label("이미지를 다운로드 하지 못했습니다.", systemImage: "x.circle")
                case .empty:
                    ProgressView()
                }
            }
            
            AsyncImage(url: self.url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            AsyncImage(url: self.url)
        }
    }
}

struct About_AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AboutAsyncImage()
    }
}
