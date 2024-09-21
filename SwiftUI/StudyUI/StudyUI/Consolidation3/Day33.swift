//
//  Day33.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/06.
//

import SwiftUI

struct Day33: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount: CGSize = CGSize.zero

    @State private var linearGradientDragAmount: CGSize = CGSize.zero
    
    @State private var isShowingCyan = false
    @State private var isShowingYellow = true
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingCyan.toggle()
                    self.isShowingYellow = true
                }
            }
            
            if self.isShowingYellow {
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 250, height: 50)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        withAnimation {
                            self.isShowingYellow.toggle()
                        }
                    }
            }
            
            if self.isShowingCyan {
                Rectangle()
                    .fill(.cyan)
                    .frame(width: 300, height: 100)
//                    .transition(.scale)
                    .transition(.pivot)
            }
            
            
            HStack(spacing: 0) {
                ForEach(0..<self.letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? .blue : .red)
                        .offset(self.dragAmount)
                        .animation(.default.delay(Double(num) / 20), value: self.dragAmount)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    }
            )
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .frame(width: 200, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(self.linearGradientDragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.linearGradientDragAmount = $0.translation }
                    //                    .onEnded { _ in self.dragAmount = .zero }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.linearGradientDragAmount = .zero
                            }
                        }
                )
                        .animation(.spring(), value: self.linearGradientDragAmount)
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(self.amount), anchor: self.anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct Day33_Previews: PreviewProvider {
    static var previews: some View {
        Day33()
    }
}
