//
//  About_Scene.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI


struct AboutScene: App {
    // Scene
    // - View Hierarchy을 담고 있는 Container
    // - Platform과 현재 App의 상태에 따라서 View Hierarchy을 표시하는 시점 & 방식을 자동으로 처리해준다.
    // - 대부분의 시스템을 OS에 따라 알아서 처리해준다.
    
    var body: some Scene {
        // WindowGroup
        // - SwiftUI가 제공하는 가장 기본적인 Scene
        CustomScene()
    }
}

struct CustomScene: Scene {
    // scenePhase
    // - system 공유 객체
    // - active: 이벤트 처리 가능
    // - inactive: 화면에 표시되어 있지만 이벤트 처리 불가능
    // - background: 말그대로 백그라운드
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: self.scenePhase) { phase in
            // App에 포함된 모든 Scene 중에 단 하나라도 active라면 active 반환
            // App에 포함된 모든 Scene이 inactive일 때, inactive 반환
            if phase == .background {
                
            }
        }
    }
}
