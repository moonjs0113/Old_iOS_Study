//
//  MethodSwizzling.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/05/11.
//

import SwiftUI

class SwizzlingClass {
    @objc dynamic func originFunction() -> String{
        return #function
    }
}

extension SwizzlingClass {
    class func methodSwzzling() {
        let originFunctionSelector = #selector(SwizzlingClass.originFunction)
        let swizzlingFunctionSelector = #selector(SwizzlingClass.swizzlingFunction)
        
        guard
            let originalMethod = class_getInstanceMethod(SwizzlingClass.self, originFunctionSelector),
            let swizzledMethod = class_getInstanceMethod(SwizzlingClass.self, swizzlingFunctionSelector)
        else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func swizzlingFunction() -> String{
        return #function
    }
}

struct MethodSwizzling: View {
    let swizzlingClass = SwizzlingClass()
    @State private var switchMethodString = "tap button"
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                Text(self.switchMethodString)
                Button("Switch Method") {
                    SwizzlingClass.methodSwzzling()
                    self.switchMethodString = self.swizzlingClass.originFunction()
                }
//                Text(
//"""
//class SwzzlingClass {
//    @objc dynamic func originFunction() -> String{
//        return #function
//    }
//}
//
//extension SwzzlingClass {
//    class func methodSwzzling() {
//        let originFunctionSelector = #selector(SwzzlingClass.originFunction)
//        let swzzlingFunctionSelector = #selector(SwzzlingClass.swzzlingFunction)
//
//        guard
//            let originalMethod = class_getInstanceMethod(SwzzlingClass.self, originFunctionSelector),
//            let swizzledMethod = class_getInstanceMethod(SwzzlingClass.self, swzzlingFunctionSelector)
//        else { return }
//        method_exchangeImplementations(originalMethod, swizzledMethod)
//    }
//
//    @objc func swzzlingFunction() -> String{
//        return #function
//    }
//}
//
//struct MethodSwizzling: View {
//    let swzzlingClass = SwzzlingClass()
//    @State private var switchMethodString = ""
//
//    var body: some View {
//        ScrollView{
//            VStack {
//                Text(self.switchMethodString)
//                Button("Switch Method") {
//                    SwzzlingClass.methodSwzzling()
//                    self.switchMethodString = self.swzzlingClass.originFunction()
//                }
//            }
//        }
//    }
//}
//"""
//                )
//                .font(.caption)
            }
        }
    }
}

struct MethodSwizzling_Previews: PreviewProvider {
    static var previews: some View {
        MethodSwizzling()
    }
}
