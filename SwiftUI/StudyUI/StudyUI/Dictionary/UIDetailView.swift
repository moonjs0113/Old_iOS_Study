//
//  UIDetailView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/29.
//

import SwiftUI

struct UIDetailView: View {
    var uiComponent: UIComponent
    
    var body: some View {
        VStack {
            Text(self.uiComponent.name)
            Text(self.uiComponent.script)
        }
    }
}

//struct UIDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        UIDetailView()
//    }
//}
