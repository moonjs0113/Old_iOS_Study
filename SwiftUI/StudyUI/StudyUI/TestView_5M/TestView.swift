//
//  TestView.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/18.
//

import SwiftUI

struct TestView: View {
    @State var localString = ""
    @State var globalString = ""
    @GestureState var isDetectingLongPress = false
    @GestureState var dragAmount = CGSize.zero
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 3)
        //            .updating(<#T##state: GestureState<State>##GestureState<State>#>, body: <#T##(Bool, inout State, inout Transaction) -> Void#>)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                print(gestureState)
                print(currentState)
                print(transaction)
                gestureState = currentState
                
            }
    }
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("asdfgasfkdlj h")
                Text("asdfgasfkdldfasdf")
                Text("asdfgasfkdlj hasdfasd")
                Text(self.localString)
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { drag in
                    print("local")
                    print(drag.location)
                    //                    self.localString = "\(drag.location.x) \(drag.location.y)"
                })
            
            VStack {
                Text("asdfgasfkdlj h")
                Text("asdfgasfkdldfasdf")
                Text("asdfgasfkdlj hasdfasd")
                Text(self.globalString)
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { drag in
                    print("global")
                    print(drag.location)
                    //                    self.globalString = "\(drag.location.x) \(drag.location.y)"
                })
            
            Circle()
                .fill(self.isDetectingLongPress ? Color.red : Color.green)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(longPress)
            Rectangle()
                .fill(.cyan)
                .frame(width: 100, height: 100)
                .offset(dragAmount)
                .gesture(
                    DragGesture().updating($dragAmount) { value, state, transaction in
                        state = value.translation
                    }
                )
            NavigationLink(destination: HomeView()) {
                Text("HomeView")
            }
            NavigationLink(destination: ScaledMetricView()) {
                Text("ScaledMetricView")
            }
        }
    }
}

struct ScaledMetricView: View {
    @ScaledMetric(relativeTo: .largeTitle) var fontSize: CGFloat = 20
    @ScaledMetric(relativeTo: .largeTitle) var imageSize: CGFloat = 100
    var body: some View {
        VStack{
            Text("cloud.sun.bolt.fill")
                .font(.system(size: self.fontSize, weight: .regular, design: .default)  )
            Image(systemName: "cloud.sun.bolt.fill")
                .resizable()
                .frame(width: self.imageSize, height: self.imageSize)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct HomeView: View {
    @Namespace var namespace
    @State var isDisplay = true
    
    var body: some View {
        ZStack {
            if isDisplay {
                View1(namespace: namespace, isDisplay: $isDisplay)
            } else {
                View2(namespace: namespace, isDisplay: $isDisplay)
            }
        }
    }
}

struct View1: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Rectangle()
                .fill(.cyan)
                .frame(width: 150, height: 100)
                .matchedGeometryEffect(id: "img", in: namespace)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onTapGesture {
            withAnimation {
                self.isDisplay.toggle()
            }
        }
    }
}

struct View2: View {
    let namespace: Namespace.ID
    @Binding var isDisplay: Bool
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(.cyan)
                .frame(width: 300, height: 200)
                .matchedGeometryEffect(id: "img", in: namespace)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .onTapGesture {
            withAnimation {
                self.isDisplay.toggle()
            }
        }
    }
}
