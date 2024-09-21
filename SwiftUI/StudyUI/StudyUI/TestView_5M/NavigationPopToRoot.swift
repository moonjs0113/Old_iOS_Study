//
//  NavigationPopToRoot.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/05/09.
//

import SwiftUI

class PopToRoot: ObservableObject {
    @Published var popToRootBool: Bool
    
    init(popToRootBool: Bool) {
        self.popToRootBool = popToRootBool
    }
    
    deinit {
        print("PopToRoot", #function)
    }
}

struct RootView: View {
    @ObservedObject var ePopToRoot: PopToRoot = PopToRoot(popToRootBool: false)
    // or @StateObject
    
    var body: some View {
        NavigationView {
            NavigationLink("NavigationPop to Next View1", isActive: self.$ePopToRoot.popToRootBool) {
                NavigationPopToRoot()
            }
        }
        .environmentObject(self.ePopToRoot)
    }
}

struct NavigationPopToRoot: View {
    var body: some View {
        NavigationLink("Next View2", destination: NavigationPopToRoot1())
    }
}

struct NavigationPopToRoot1: View {
    var body: some View {
        NavigationLink("Next View3", destination: NavigationPopToRoot2())
    }
}

struct NavigationPopToRoot2: View {
    @EnvironmentObject var ePopToRoot: PopToRoot
    
    var body: some View {
        Button{
            self.ePopToRoot.popToRootBool.toggle()
        } label: {
            Text("Go To Root")
        }
        NavigationLink("Next View", destination: NavigationPopToRoot3())
    }
}

struct NavigationPopToRoot3: View {
    var body: some View {
        Text("in NavigationPopToRoot3")
    }
}

struct PopToRoot_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

//var sumClosures = { (x: Int, y: Int) - > Int
//
//}
//sumClosures = { x, y in
//    return x + y
//}
