//
//  About_TextEditor.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutTextEditor: View {
    @State private var content = ""
    
    var body: some View {
        TextEditor(text: self.$content)
            .padding()
//            .font(<#T##font: Font?##Font?#>)
//            .foregroundColor(<#T##color: Color?##Color?#>)
//            .multilineTextAlignment(<#T##alignment: TextAlignment##TextAlignment#>)
//            .lineSpacing(<#T##lineSpacing: CGFloat##CGFloat#>)
//            .keyboardType(<#T##type: UIKeyboardType##UIKeyboardType#>)
//            .disableAutocorrection(<#T##disable: Bool?##Bool?#>)
//            .textInputAutocapitalization(<#T##autocapitalization: TextInputAutocapitalization?##TextInputAutocapitalization?#>)
    }
}

struct About_TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        AboutTextEditor()
    }
}
