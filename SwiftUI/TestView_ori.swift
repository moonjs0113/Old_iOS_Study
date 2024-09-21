//
//  TestView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/11.
//

import SwiftUI

struct TestView: View {
    
    @State var minimumScaleFactorValue: Double = 0.5
    @State var fontSize: CGFloat = 15
    
    var body: some View {
        VStack(spacing: 5) {
            Text("minimumScaleFactorValue : \(self.minimumScaleFactorValue)")
            Text("fontSize : \(self.fontSize)")
            VStack {
                TestText2(fontSize: self.fontSize, minimumScaleFactorValue: self.minimumScaleFactorValue)
                    .truncationMode(.head)
                TestText2(fontSize: self.fontSize, minimumScaleFactorValue: self.minimumScaleFactorValue)
                    .truncationMode(.middle)
                TestText2(fontSize: self.fontSize, minimumScaleFactorValue: self.minimumScaleFactorValue)
                    .truncationMode(.tail)
            }
            TestText(frameWidth: 150, minimumScaleFactorValue: self.minimumScaleFactorValue)
            TestText(frameWidth: 100, minimumScaleFactorValue: self.minimumScaleFactorValue)
            TestText(frameWidth: 50, minimumScaleFactorValue: self.minimumScaleFactorValue)
            Slider(value: self.$minimumScaleFactorValue, in: 0...1)
            Slider(value: self.$fontSize, in: 5...40)
        }
    }
    
    struct TestText2: View {
        var fontSize: CGFloat
        var minimumScaleFactorValue: Double
        
        var body: some View {
            Text("This is truncation mode text element")
                .font(.system(size: self.fontSize, weight: .regular, design: .default))
                .minimumScaleFactor(self.minimumScaleFactorValue)
                .lineLimit(4)
                .frame(width: 100, height: 50)
                
        }
    }
    
    struct TestText: View {
        let fontSize: CGFloat = 40.0
        var frameWidth: CGFloat
        var minimumScaleFactorValue: Double
        
        
        var body: some View {
            Text("This is Minimumv Scale Factor")
                .font(.system(size: self.fontSize, weight: .bold, design: .default))
                .minimumScaleFactor(self.minimumScaleFactorValue)
                .lineLimit(5)
                .frame(width: self.frameWidth, height: 50)
                .border(Color.gray)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
var asdf = """

.multilineTextAlignment(.leading)
// Text가 2줄 이상이 되었을때 정렬방식
// Docs 프로그램의 왼쪽/오른쪽/중앙정렬 개념과 비슷

.allowsTightening(false)


.minimumScaleFactor()는
작아질 수 있는 최소한의 글자 크기 비율
만약 지정된 폰트 크기가 20 이라면 인자값이 0.5일때
글자 영역이 동적으로 작아질때 폰트크기가 최대 10까지는 줄어들지만
그 이하로 글자 크기가 내려가지 않아요!
10 이하로 떨어져야 하는 경우, 문자를 잘라버립니다. ( qwerasdf -> qweras... 이렇게 나옵니다)

숫자가 작을 수록(0에 가까울수록) -> 난 이만큼 더 줄어들 수 있다!
숫자가 작을 수록(1에 가까울수록) -> 난 더 못작아진다!
라고 생각하시면 될 거 같아요!

"""
