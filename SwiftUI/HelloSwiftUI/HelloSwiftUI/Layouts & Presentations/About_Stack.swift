//
//  Stack.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct CardSign {
    public var heart: some View {
        Image(systemName: "suit.heart.fill")
            .resizable()
            .frame(width: 50, height: 50)
            .foregroundColor(.red)
            .opacity(0.25)
    }
    
    public var club: some View {
        Image(systemName: "suit.club.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.black)
            .opacity(0.25)
    }
    
    public var spade: some View {
        Image(systemName: "suit.spade.fill")
            .resizable()
            .frame(width: 150, height: 150)
            .foregroundColor(.black)
            .opacity(0.25)
    }
    
    public var diamond: some View {
        Image(systemName: "suit.diamond.fill")
            .resizable()
            .frame(width: 200, height: 200)
            .foregroundColor(.red)
            .opacity(0.25)
    }
}

struct NumberView: View {
    let number: Int
    
    init(number: Int) {
        self.number = number
        print("NumberView \(number) initialized")
    }
    
    var body: some View {
        Text("\(number)")
            .font(.largeTitle)
            .frame(width: 150, height: 150)
            .background(.yellow)
            .clipShape(Circle())
    }
}

struct AboutHVStack: View {
    let cardSign: CardSign = CardSign()
    
    var body: some View {
        // ctrl + opt click -> Inspector
        // cmd + click -> Embed Layout
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                self.cardSign.heart
                self.cardSign.club
                self.cardSign.spade
                self.cardSign.diamond
            }
            .frame(maxHeight: .infinity)
            //        .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
        }
    }
    
    
}

struct AboutZStack: View {
    let cardSign: CardSign = CardSign()
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            self.cardSign.heart
            self.cardSign.club
            self.cardSign.spade
                .offset(x: -20, y: -130)
            self.cardSign.diamond
                .offset(x: 50, y: 50)
        }
    }
}

struct AboutLazyStack: View {
    var body: some View {
        ScrollView(.horizontal) {
            // Stack은 기본적으로 Scroll을 지원하지 않는다.
            // Stack은 내부에 있는 View을 동시에 초기화한다.
            // -> 그래서 Lazy를 쓴다.
            LazyHStack {
                ForEach(0..<10000) { num in
                    NumberView(number: num)
                }
            }
        }
    }
}

struct Stack_Previews: PreviewProvider {
    static var previews: some View {
//        AboutHVStack()
//        AboutZStack()
        AboutLazyStack()
    }
}
