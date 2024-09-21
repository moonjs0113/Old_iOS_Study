//
//  Day23.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/21.
//

import SwiftUI

// View & Modifier 정의 및 확장 부분이라 코드 이해가 중요한 파트
struct Day23: View {
    // 프로퍼티로 생성해서 사용가능
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        // modifier도 순서가 있음, 순서 중요함.
        Form {
            Text("Custom Modifier")
                .modifier(Title())
            
            Text("Custom Modifier with Extension")
                .titleStyle()
            
            CapsuleText(text: "Capsule Text")
            OutCapsuleText(text: "Out Capsule Text")
            
            self.spells
            
            HStack(alignment: .center) {
                self.motto1
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                self.motto2
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: Day23_2()) {
                Text("Go to Day23+")
            }
            
            Text("Color Show!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
                .padding()
                .background(.cyan)
                .padding()
                .background(.white)
                .padding()
                .background(.purple)
                .padding()
                .background(.secondary)
                .blur(radius: 2)
            
            HStack(alignment: .center) {
                Button("Hello, World! Button") { }
                .background(.red)
                .frame(width: 150, height: 100)
                Button("Hello, World! Button") { }
                .frame(width: 200, height: 100)
                .background(.red)
            }
            .frame(maxWidth: .infinity)
            
            Color.purple
                .frame(width: 150, height: 30)
                .watermarked(with: "SwiftUI Study App")
        }
    }
    
    struct CapsuleText: View {
        var text: String
        
        var body: some View {
            Text(text)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
}

// View Struct 를 직접 만들어 사용해도됨
// 클래스화랑 비슷함
struct OutCapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

// Modifier 정의해서 사용가능
// ViewModifier 프로토콜 채택
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .background(.cyan)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// Custom Modifier Extension에 놓고 쓰면 편함
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

// 워터마크 예제
// Modifier에 또 다른 View 넣는 것도 가능
struct Watermark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct Day23_Previews: PreviewProvider {
    static var previews: some View {
        Day23()
    }
}
