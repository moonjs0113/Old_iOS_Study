//
//  ViewModifierExample.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ViewModifierExample: View {
    var body: some View {
        Text("ViewModifier")
            .customModifier(isBold: true)
    }
}

extension Text {
    public func isBold(_ value: Bool) -> Text {
        return value ? self.bold() : self
    }
    
    public func customModifier(isBold: Bool) -> some View {
        return self.isBold(isBold).customModifier()
    }
}


extension View {
    public func customModifier() -> some View {
        modifier(CustomViewModifier())
    }
}

struct CustomViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .frame(width: 150, height: 30)
            .padding()
    }
}

struct ViewModifierExample_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierExample()
    }
}


