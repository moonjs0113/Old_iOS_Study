//
//  About_App.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

class AppModel: ObservableObject {
    
}

// main: 컴파일러가 main함수 호출해준다.
//@main
struct AboutApp: App {
    @StateObject private var appModel = AppModel()
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appModel)
        }
    }
}

// AppDelegate Example
//class AppDelegate: NSObject, UIApplicationDelegate {
//
//}
