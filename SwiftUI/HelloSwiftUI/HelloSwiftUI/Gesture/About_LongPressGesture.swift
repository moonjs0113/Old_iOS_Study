//
//  About_LongPressGesture.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutLongPressGesture: View {
    @State private var showOriginal = true
    @State private var showOriginal2 = true
    let text = "You misused Environment Object. This should work: struct Knowledge: Identifiable, Codable { var id = UUID() var term: String var explanation: String? var tags: String? } class Deck: ObservableObject { @Published var knowledgeArray : [Knowledge] = [] init() { if let savedItems = UserDefaults.standard.data(forKey: KnowledgeItems) { if let decodedItems = try? JSONDecoder().decode([Knowledge].self, from:"
    
    var longPress: some Gesture {
        LongPressGesture()
        // 잘 끝나면 true return
            .onEnded { bool in
                print(bool)
                showOriginal2.toggle()
            }
    }
    
    var body: some View {
        VStack {
            Text(text)
                .blur(radius: showOriginal ? 0.0 : 40.0)
                .animation(.easeInOut, value: showOriginal)
                .onLongPressGesture(minimumDuration: 0.5,
                                    maximumDistance: 10) {
                    showOriginal.toggle()
                } onPressingChanged: { pressing in
                    // Gestrue 시작 시, true
                    // perform 종료 후, false 전달
                    print(pressing)
                }
            
            Divider()
            
            Text(text)
                .blur(radius: showOriginal2 ? 0.0 : 40.0)
                .animation(.easeInOut, value: showOriginal2)
                .gesture(self.longPress)
            
        }
        
    }
}

struct About_LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        AboutLongPressGesture()
    }
}
