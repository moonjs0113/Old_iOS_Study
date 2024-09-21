//
//  AnimationAsync.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/24.
//

import SwiftUI

struct AnimationAsync: View {
    @State private var showNext = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: self.$showNext) {
                    NextView()
                } label: {
                    Text("go Next")
                }
                AnimationView()
                    .padding()
            }
        }
    }
}

struct NextView: View {
    var body: some View {
        Text("Next View")
    }
}

struct AnimationView: View {
    @State private var isAppear = true
    @State private var left = true
    @State private var item: DispatchWorkItem!
    
    var body: some View {
        
        Image(systemName: "drop")
            .font(.largeTitle)
            .offset(x: self.left ? -100 : 100, y: 0)
            .onAppear {
                if self.isAppear {
                    DispatchQueue.main.async {
                        withAnimation(Animation.easeInOut.repeatForever()){
                            self.left.toggle()
                        }
                    }
                }
            }
            .onDisappear {
                self.isAppear = false
            }
        
    }
}


struct AnimationAsync_Previews: PreviewProvider {
    static var previews: some View {
        AnimationAsync()
    }
}

//    .onAppear {
//
//        if self.isAppear {
////                    withAnimation(Animation.easeInOut.repeatForever()){
////                        self.left.toggle()
////
////                    }
////                    self.isAppear = false
//            //                    //                                    print("onAppear in If \(self.isAppear)")
//            //                }
//            //                //                                print("onAppear out If \(self.isAppear)")
//            self.item = DispatchWorkItem {
//                withAnimation(Animation.easeInOut.repeatForever()){
////                            print("withAnimation")
//                    self.left.toggle()
//                    self.isAppear = false
//                }
//            }
//            DispatchQueue.main.async(execute: item)
//        }
//    }
//    .onDisappear {
////                self.item.cancel()
//        //                print("onDisappear \(self.isAppear)")
//                        self.isAppear = false
//        //                print("onDisappear \(self.isAppear)")
//    }
