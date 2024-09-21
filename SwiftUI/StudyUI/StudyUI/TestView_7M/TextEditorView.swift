//
//  TextEditorView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/07/06.
//

import SwiftUI
import Combine

//class ViewModelSample: ObservableObject {
//    private let objectWillChange = ObservableObjectPublisher()
//
//    func updateView(){
//        objectWillChange.send()
//    }
//}

struct TextEditorView: View {
    var body: some View {
        Form {
            Section {
                Text("예를 들어")
            }
            
            TEView()
        }
    }
}

struct TEView: View {
    @AppStorage("TEXT_EDITOR") private var text = ""
    @State private var isUpdate = false
    
    var body: some View{
        TextEditor(text: $text)
            .frame(maxHeight: 200)
            .onAppear() {
                ObservableObjectPublisher().send()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                    if !self.isUpdate {
//                        self.isUpdate = true
//                    }
//                }
            }
            .onChange(of: self.isUpdate) { _ in
                
            }
    }
}


struct TextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
    }
}
