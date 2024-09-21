//
//  About_Overlay.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct EmojiView: View {
    let emoji: String
    
    var body: some View {
        Text("\(emoji)")
            .font(.system(size: 100))
            .frame(width: 150, height: 150)
            .background(.gray.opacity(0.3))
            .clipShape(Circle())
    }
}

struct AboutOverlay: View {
    @State private var selected: Bool = false
    var body: some View {
        VStack {
            // overlay의 Frame은 적용되는 View의 Frame을 따라간다.
            EmojiView(emoji: "🤔")
                .overlay(.blue)
            EmojiView(emoji: "🤔")
                .overlay(.ultraThinMaterial, in: Circle())
            EmojiView(emoji: "🤔")
                .overlay(alignment: .bottomTrailing) {
                    if self.selected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                    }
                }
                .onTapGesture {
                    self.selected.toggle()
                }
        }
        
    }
}

struct About_Overlay_Previews: PreviewProvider {
    static var previews: some View {
        AboutOverlay()
    }
}
