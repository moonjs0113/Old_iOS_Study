//
//  ViewContainers.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/22.
//

import SwiftUI

struct ViewContainers: View {
    var body: some View {
        TabView{
            ViewContainerTab1()
            .tabItem {
                Text("ViewContainers1")
            }
            
            ViewContainerTab2()
            .tabItem {
                Text("ViewContainers2")
            }
            
            ViewContainerTab3()
            .tabItem {
                Text("ViewContainers3")
            }
        }
    }
}

struct ViewContainerTab1: View {
    @State var isActionSheet: Bool = false
    @State var isConfirmationDialog: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 25){
                Text("전체 View: NavigationView, TabView")
                Text("1번 탭: HStack, VStack, ZStack\nLazyHStack, LazyVStack\nScrollView, ForEach, Section\nActionSheet, ConfirmationDialog\nView Container가 최대한 다 섞인 혼종 View입니다.")
            }
            
            VStack(spacing: 15) {
                Text("해당 View는 VStack으로 감싸져있습니다.")
                HStack(spacing: 20){
                    Text("☀️")
                    Text("spacing이 20인 HStack입니다.")
                }
                Button("ActionSheet 버튼") {
                    self.isActionSheet.toggle()
                }
                Button("ConfirmationDialog 버튼") {
                    self.isConfirmationDialog.toggle()
                }
                ZStack {
                    Text("혼돈의 ZStack")
                    Text("ㅋㅌㅍㅎ")
                        .foregroundColor(.green)
                    Text("ㅂㅅㅇㅈㅊ")
                        .foregroundColor(.red)
                    Text("ㄱㄴㄷㄹㅁ")
                        .foregroundColor(.blue)
                    Text("ZStack의 제일 위")
                        .foregroundColor(.gray.opacity(0.5))
                }
            }
            .padding()
            
            LazyHStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                ForEach(1..<6) { i in
                    Section {
                        Text("LazyHStack 속 ForEach문 No.\(i)")
                        ForEach(0..<5) { j in
                            Text("Section Text\(j)")
                        }
                    } header: {
                        Text("LazyHStackSection")
                    }
                }
            }
            
            LazyVStack(spacing: 20, pinnedViews: [.sectionHeaders]) {
                ForEach(1..<6) { i in
                    Section {
                        Text("LazyVStack 속 ForEach문 No.\(i)")
                        ForEach(0..<5) { j in
                            Text("Section Text\(j)")
                        }
                    } header: {
                        Text("LazyVStackSection No.\(i)")
                    }
                }
            }
        }
        .actionSheet(isPresented: self.$isActionSheet) {
            ActionSheet(title: Text("ActionSheet Title입니다."),
                        message: Text("message입니다. actionSheet가 iOS 15.4까지만 지원된다고 합니다. 아쉬우십니까?"),
                        buttons: [.default(Text("default 네")),
                                  .destructive(Text("destructive 아니오")),
                                  .cancel()]
            )
        }
        .confirmationDialog(Text("이게 ConfirmationDialog입니다."),
                            isPresented: self.$isConfirmationDialog,
                            titleVisibility: .visible) {
            Button {
                
            } label: {
                Text("ConfirmationDialog Action")
            }
            Button("Cancel", role: .cancel) {
                
            }
        } message: {
            Text("ConfirmationDialog Message")
        }
    }
}

struct ViewContainerTab2: View {
    private var gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    private var colors: [Color] = [.yellow, .purple, .green]
    
    var body: some View {
        VStack {
            Text("2번 탭: LazyHGrid, LazyVGrid, GridItem\nList, Form, Group\nGroupBox, Spacer, Divider\n Alert, EmptyView, AnyView, TupleView")
            ScrollView {
                LazyVGrid(columns: self.gridItems) {
                    ForEach((0...100), id: \.self) {
                        Image(systemName: self.symbols[$0 % self.symbols.count])
                            .font(.system(size: 30))
                            .frame(width: 50, height: 50)
                            .background(self.colors[$0 % self.colors.count])
                            .cornerRadius(10)
                    }
                }
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: self.gridItems) {
                    ForEach((0...100), id: \.self) {
                        Image(systemName: self.symbols[$0 % self.symbols.count])
                            .font(.system(size: 30))
                            .frame(width: 50, height: 50)
                            .background(self.colors[$0 % self.colors.count])
                            .cornerRadius(10)
                    }
                }
            }
            Form {
                Group {
                    Text("I'm Text in Group")
                    Text("I'm Text in Group")
                }
                Text("I'm Text in Form")
            }
            List {
                ForEach((0...15), id: \.self) {
                    Text("Text in List no.\($0)")
                }
            }
        }
    }
}

struct ViewContainerTab3: View {
    @State var isAnyView: Bool = false
    @State var showAlert: Bool = false
    @State var isViewBuilder: Bool = false
    
    func showAnyView() -> some View{
        if self.isAnyView {
            return AnyView(Day20())
        } else {
            return AnyView(TestView())
        }
    }
    
    func group() -> some View{
        Group {
            if self.isAnyView {
                Day20()
            } else {
                TestView()
            }
        }
    }
    
    @ViewBuilder
    func useViewBuilder(whatView: Bool) -> some View {
        if whatView {
            Day43()
        } else {
            TestView()
        }
    }
    
    @ViewBuilder
    func showViewBuilder() -> some View{
        if self.isViewBuilder {
            Day43()
        } else {
            TestView()
        }
    }
    
    func viewBuilderParameter<V: View>(@ViewBuilder view: (String) -> V) {
        
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 15) {
                Text("3번 탭: GroupBox, Spacer, Divider\n Alert, EmptyView, AnyView, TupleView")
                GroupBox("GroupBox") {
                    VStack {
                        Divider()
                        Text("GroupBox Content")
                        Spacer()
                        Divider()
                    }
                }
                .padding()
                EmptyView()
                Button("Alert 버튼") {
                    self.showAlert.toggle()
                }
                
                Button("AnyView 버튼") {
                    self.isAnyView.toggle()
                }
                self.showAnyView()
                
                Button("ViewBuilder 버튼") {
                    self.isViewBuilder.toggle()
                }
                NavigationLink("ViewBuilder", destination: self.showViewBuilder())
            }
        }
        .alert("Alert Title", isPresented: self.$showAlert){
            Button("OK") {
                self.showAlert = false
            }
        }
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
        ViewContainers()
    }
}



