//
//  About_InteractiveDismiss.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

// InteractiveDismiss: Card Modal을 드래그해서 닫는 Interactive

struct AboutInteractiveDismiss: View {
    @State private var showComposer = false
    @State private var edited  = false
    
    var body: some View {
        Button {
            self.showComposer = true
        } label: {
            Text("Show Me!")
        }
        .padding()
        .sheet(isPresented: self.$showComposer, onDismiss: nil) {
            // Binding 변수를 Raw Value로 쓰고 싶다면
            // .constant(Value) -> Static Binding
            
//            ComposeScene(edited: .constant(false))
            ComposeScene(edited: self.$edited)
            // 무조건 막고싶다면,
//                .interactiveDismissDisabled()
            // 조건에 따라 막고싶다면,
                .interactiveDismissDisabled(self.edited)
        }
    }
}

struct ComposeScene: View {
    @Binding var edited: Bool
    @State private var title: String = ""
    @State private var content: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                    .onChange(of: title) { _ in
                        edited = title != "" || content != ""
                    }
                
                TextEditor(text: $content)
                    .onChange(of: title) { _ in
                        edited = title != "" || content != ""
                    }
            }
            .navigationTitle("Compose")
        }
    }
}

struct About_InteractiveDismiss_Previews: PreviewProvider {
    static var previews: some View {
        AboutInteractiveDismiss()
    }
}
