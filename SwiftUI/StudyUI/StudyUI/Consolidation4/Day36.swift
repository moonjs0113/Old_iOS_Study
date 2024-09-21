//
//  Day36.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/07.
//

import SwiftUI

struct CodableUser: Codable {
    var firstName: String
    var lastName: String
}

// @StateObject 로 사용할 Class
// ObservableObject Protocol 채택
class User36: ObservableObject {
    // @Published: ObservableObject의 상태 구독할 변수
    @Published var firstName = "Bilbo"
     var lastName = "Baggins"
}

class User36_2: ObservableObject {
    // @Published: ObservableObject의 상태 구독할 변수
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    @SceneStorage("SCENE_TAP") private var AppStorageTapCount = 0
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "Tap")
    
    let centerPosition : (GeometryProxy) -> CGPoint = { proxy in
        return CGPoint(x: proxy.frame(in: .local).midX,
                       y: proxy.frame(in: .local).midY)
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Hello, \(self.name), \(self.AppStorageTapCount), \(tapCount)")
                Button("SceneStorage") {
                    self.AppStorageTapCount += 2
                }
                .padding()
                Button("Dismiss") {
                    self.dismiss()
                }
            }
            .position(x: self.centerPosition(proxy).x,
                      y: self.centerPosition(proxy).y)
        }
    }
}

struct Day36: View {
    // @StateObject: Custom Object일때 사용하는 듯
    @ObservedObject private var user = User36()
    @StateObject private var user2 = User36_2()
    @State private var showingSheet = false
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "tapCount")
    @AppStorage("tapCount") private var AppStorageTapCount = 0
    @SceneStorage("tapCount") private var sceneStorageTapCount = 0
    @SceneStorage("text") var text = ""
    
    @State private var codableUser = CodableUser(firstName: "Taylor", lastName: "Swift")
    @State private var loadCodableUser: CodableUser?
    @State private var isLoadSuccess = false
    
    func removeRows(at offsets: IndexSet) {
        self.numbers.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            VStack{
                Text("Your name is \(self.user.firstName) \(self.user.lastName)")
                TextField("First name", text: self.$user.firstName)
                TextField("Last name", text: self.$user.lastName)
                TextEditor(text: $text)
            }
            
            VStack{
                Text("Your name is \(self.user2.firstName) \(self.user2.lastName)")
                TextField("First name", text: self.$user2.firstName)
            }
            
            
            Button("Show sheet") {
                self.showingSheet.toggle()
            }
            .sheet(isPresented: self.$showingSheet) {
                SecondView(name: "@m_oon_js")
            }
            
            List {
                ForEach(self.numbers, id: \.self) {
                    Text("Row \($0)")
                }
                .onDelete(perform: self.removeRows(at:))
            }
            
            Button("Add Number") {
                self.numbers.append(self.currentNumber)
                self.currentNumber += 1
                self.user2.firstName = (self.user2.firstName == "asdf") ? "1234135" : "asdf"
            }
            
            NavigationLink("Day37", destination: Day37())
            
            VStack(spacing: 10) {
                Button("UserDefaults Tap count: \(self.tapCount)") {
                    self.tapCount += 1
                    UserDefaults.standard.set(self.tapCount, forKey: "tapCount")
                }
                
                Button("AppStorage Tap count: \(self.AppStorageTapCount)") {
                    self.AppStorageTapCount += 1
                }
                
                Button("SceneStorage Tap count: \(self.sceneStorageTapCount)") {
                    self.sceneStorageTapCount += 1
                }
                
                Button("Save Codable User") {
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(self.codableUser) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
                
                Button("Load Codable User") {
                    let decoder = JSONDecoder()
                    if let userData = UserDefaults.standard.data(forKey: "UserData") {
                        if let data = try? decoder.decode(CodableUser.self, from: userData) {
                            self.loadCodableUser = data
                        }
                    }
                    self.isLoadSuccess.toggle()
                }
                
                if self.isLoadSuccess {
                    Rectangle()
                        .fill(.yellow)
                        .frame(width: 250, height: 50)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    if let codableUser = self.loadCodableUser {
                        Text("Load name is \(codableUser.firstName) \(codableUser.lastName)")
                    }
                }
                
                Button("Delete Codable User") {
                    self.loadCodableUser = nil
                    UserDefaults.standard.removeObject(forKey: "UserData")
                }
            }
        }
        .toolbar {
            EditButton()
        }
    }
}

struct Day36_Previews: PreviewProvider {
    static var previews: some View {
        Day36()
    }
}
