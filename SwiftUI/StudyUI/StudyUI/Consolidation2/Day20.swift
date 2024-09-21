//
//  Day20.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/19.
//

import SwiftUI

struct Day20: View {
    @State private var showingAlert = false
    
    func buttonFunction() {
        print("Click!")
    }
    
    var body: some View {
        // Form 으로 안 감싸면 화면 밖으로 나가버림
        VStack {
            HStack(alignment: .center, spacing: 5) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Hello, SwiftUI").background(.blue)
                    Text("Hello, SwiftUI 2")
                    Button {
                        print("Button With Label")
                    } label: {
                        Label("Label in Button", systemImage: "pencil")
                    }
                    RadialGradient(gradient: Gradient(colors: [.white, .blue, .black]),
                                   center: .bottomLeading, startRadius: 50, endRadius: 220)
                }.background(.brown)
                VStack(alignment: .center, spacing: 20) {
                    Text("VStack")
                    Text("Your content")
                        .foregroundStyle(.secondary) // 배경색, 전경색에 영향을 받음
                    //                    .foregroundColor(.secondary) // 배경색, 전경색 영향 안 받음
                        .padding(10)
                        .background(.ultraThinMaterial)
                    Button {
                        print("Button With Text & Image")
                    } label: {
                        Text("Tap me!")
                            .padding(15)
                            .foregroundColor(.white)
                            .background(.mint)
                        Image(systemName: "pencil")
                            .renderingMode(.original)
                    }
                    Color(red: 0, green: 0.5, blue: 0.6)
                        .frame(minWidth: 50, maxWidth: 70, minHeight: 60, maxHeight: 300)
                }.background(.red)
                VStack(alignment: .trailing, spacing: 10) {
                    Button("Button with destructive", role: .destructive, action: self.buttonFunction)
//                        .buttonStyle(.borderedProminent)
                        .buttonStyle(.bordered)
                        .tint(.mint)
                    Color.cyan.padding(5).frame(width: 100, height: 40)
                    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                    ZStack(alignment: .top) {
                        Text("Hello, SwiftUI")
                        Text("ZStack")
                    }
                    Button("Show Alert") {
                        self.showingAlert = true
                    }.alert("Alert Message", isPresented: $showingAlert) {
                        Button("OK"){ }
                    }
                }
            }
            NavigationLink(destination: Day21()) {
                Text("Go to Day21")
            }
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: .blue, location: 0.1),
                .init(color: .secondary , location: 0.9),
            ]), startPoint: .bottomTrailing, endPoint: .top)
        }
        .padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
        .ignoresSafeArea()
    }
}

struct Day20_Previews: PreviewProvider {
    static var previews: some View {
        Day20()
    }
}
