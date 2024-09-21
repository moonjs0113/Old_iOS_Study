//
//  Day39.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/14.
//

import SwiftUI

struct CustomText: View {
    let text: String
    
    var body: some View {
        Text(self.text)
    }
    
    init(_ text: String) {
        print("New Custom TExt")
        self.text = text
    }
}

struct Day39User: Codable {
    let name: String
    let address: Day39Address
}

struct Day39Address: Codable {
    let street: String
    let city: String
}

struct Day39: View {
    @State private var decodeString: String = "decode"
    
    @State private var showingDay40: Bool = false
    
    var body: some View {
//        ScrollView(.horizontal) {
        ScrollView() {
            // Lazy*Stack -> 화면 보여야 데이터 로드
            LazyVStack(spacing: 10) {
                ForEach(0..<20) {
                    CustomText("Item \($0) \(self.decodeString)")
//                    Text("Item \($0)")
                        .font(.title)
                }
                GeometryReader { geo in
                    Image("US")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .clipped()
                }
                NavigationLink("Next Page", destination: Day39_2())
                Button("Decode JSON") {
                    let input = """
                    {
                        "name": "Taylor Swift",
                        "address": {
                            "street": "555, Taylor Swift Avenue",
                            "city": "Nashville"
                        }
                    }
                    """
                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    if let user = try? decoder.decode(Day39User.self, from: data) {
                        self.decodeString = user.address.street
                    }
                }
                NavigationLink("Next Page", destination: Day39_3())
                Button("Day40") {
                    self.showingDay40 = true
                }
            }
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: self.$showingDay40) {
            Day40()
        }
    }
}

struct Day39_Previews: PreviewProvider {
    static var previews: some View {
        Day39()
    }
}
