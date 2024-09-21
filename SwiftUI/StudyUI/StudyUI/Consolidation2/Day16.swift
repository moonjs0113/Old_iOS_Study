//
//  Day16.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/17.
//

import SwiftUI

struct Day16: View {
    // @State : mutating, View가 다 구조체라서 mutating 속성이 필요함
    @State private var tapCount: CGFloat = 0
    @State private var stateString: String = ""
    @State private var colorString: String = "Empty"
    
    let arrayColor: [String] = ["Red", "Blue", "Yellow", "Black", "White", "Gray", "Green", "Red", "Blue", "Yellow", "Black"]
    
    var body: some View {
        // Form = TableView 맞는듯
        // child View를 10개까지만 넣을 수 있는듯 11개가 넘어가면 오류
        // -> Section이나 Group으로 묶으면 11개 이상도 가능함
        Form {
            // Navigation 이동해서 작동
            Picker("Select Color", selection: self.$colorString) {
                // \.self 반복할 collection Data가 고유하다는 의미를 줌
                // 따라서 self.arrayColor에 중복값이 있으면 안됨
                // -> 중복값이 있어서도 컴파일 에러, 런타임 에러는 안 생김, 명시의 느낌인가봄
                ForEach(self.arrayColor, id: \.self) { color in
                    Text(color)
                }
            }
            
            Group {
                // Text = UILabel
                Text("Group, world #1").padding()
                // $ -> two-way binding 양방향 바인딩이라는 표시
                TextField("TextField #2 without padding()",text: self.$stateString)
                Text("Group, world #3 without padding()")
                Button("Tap Count: \(self.tapCount)") {
                    self.tapCount += 1
                }.padding(self.tapCount)
                Text("If you tap button, increase padding")
                Text("Text in TextField: \(self.stateString)")
            }
            Section {
                Group {
                    Text("HStack")
                }
                ForEach(4..<7) { index in // 인자 하나 받음
                    Text("Group, world #\(index)")
                }
                Section {
                    Text("Section in Section with padding").padding()
                }
            } header: {
                Text("Stack")
            }
            
            Group {
                Group {
                    Text("Group in Group #1").padding()
                }
                Section {
                    Text("Section in Group #1 without padding()")
                }
            }
            NavigationLink(destination: Day16_2()) {
                Text("Go to SwiftUI Day16 - part 2")
            }
        }
        .navigationTitle("SwiftUI Day16 - part 1")
        .navigationBarTitleDisplayMode(.inline) // .large = .automatic
    }
}

struct Day16_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Day16()
        }
    }
}
