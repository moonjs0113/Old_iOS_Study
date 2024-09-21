//
//  Day29.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/03.
//

import SwiftUI

struct Day29: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    func getFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print(fileContents)
            }
        }
    }
    
    var body: some View {
//        List(0..<3) {
        List(self.people, id: \.self) {
            Text("Dynamic row From List \($0)")
            Text("Static Text")
            Section("Dynamic 1") {
                ForEach(0..<3) {
                    Text("Dynamic row From ForEach \($0)")
                }
                NavigationLink("Go to Day30", destination: Day30())
            }
            
        }.listStyle(.grouped)
            //.colorMultiply(.blue)
            .background((Color.blue))//
    }
}

struct Day29_Previews: PreviewProvider {
    static var previews: some View {
        Day29()
    }
}
