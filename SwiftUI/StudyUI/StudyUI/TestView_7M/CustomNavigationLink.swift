//
//  CustomNavigationLink.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/07/20.
//

//
//  Temp1.swift
//  ToGather
//
//  Created by hyo on 2022/07/19.
//

import SwiftUI

struct CustomNavigationLink<DestinationView, ContentView>: View where ContentView: View, DestinationView: View {
    
    
    var destination: DestinationView
    @Binding var isActive: Bool
    //    var isActive: Binding<Bool> //= .constant(false)
    var label: () -> ContentView
    
    //    init(destination: DestinationView, isActive: Binding<Bool>, label: @escaping () -> ContentView) {
    //        self.destination = destination
    //        self.isActive = isActive
    //        self.label = label
    //    }
    //
    //    init(destination: DestinationView, label: @escaping () -> ContentView) {
    //        self.destination = destination
    //        self.label = label
    //    }
    
    init(destination: DestinationView, label: @escaping () -> ContentView) {
        self.destination = destination
        self.label = label
        self._isActive = .constant(true)
    }
    
    init(destination: DestinationView, isActive: Binding<Bool>, label: @escaping () -> ContentView) {
        self.destination = destination
        self.label = label
        self._isActive = isActive
    }
    
    
    var body: some View {
        if !isActive {
            NavigationLink(isActive: $isActive, destination: {
                destination
                    .navigationBarItems(leading: ArrowBackButton())
                    .navigationBarBackButtonHidden(true)
            }){
                label()
            }
        } else {
            NavigationLink(destination: {
                destination
                    .navigationBarItems(leading: ArrowBackButton())
                    .navigationBarBackButtonHidden(true)
            }) {
                label()
            }
        }
    }
    
    // let button = Button {~} 할때는 빌드는 되지만 뒤로가기가 되지 않았음. 아마도 초기화 시점이 문제지 않을까 싶다.
    struct ArrowBackButton: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
        var body: some View {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color.red)
            }
        }
    }
}

struct NormalThirdPage: View {
    
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            Text("세번째 페이지 컨텐츠 내용")
                .navigationTitle("세번째 페이지")
            Button {
                isActive = false
            } label: {
                Text("click")
            }
        }
        
    }
}

struct TempSecondPage: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            NavigationLink {
                NormalThirdPage(isActive: $isActive)
            } label: {
                Text("두번째 페이지 컨텐츠 내용, isActive: \(isActive ? "true" : "false")")
            }
            .navigationTitle("두번째 페이지")
//            CustomNavigationLink(destination: NormalThirdPage(isActive: $isActive)) {
//                Text("두번째 페이지 컨텐츠 내용, isActive: \(isActive ? "true" : "false")")
//                    .navigationTitle("두번째 페이지")
//            }
        }
    }
}

struct TempCustomNavigationView: View {
    @State var isActive = false
    
    var body: some View {
        //        NavigationView {
        VStack {
            NavigationLink(isActive: $isActive) {
                TempSecondPage(isActive: $isActive)
            } label: {
                Text("첫번째 페이지 isActive: \(isActive ? "true" : "false")")
            }
            .navigationTitle("첫번째 페이지")
            
//            CustomNavigationLink(destination: TempSecondPage(isActive: $isActive), isActive: $isActive) {
//                Text("첫번째 페이지 isActive: \(isActive ? "true" : "false")")
//            }
        }
        
        //        }
    }
}

struct CustomNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        TempCustomNavigationView()
    }
}
