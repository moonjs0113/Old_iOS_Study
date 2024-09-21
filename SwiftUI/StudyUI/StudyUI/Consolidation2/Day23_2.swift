//
//  Day23_2.swift
//  StudyUI
//
//  Created by 문종식 on 2022/02/22.
//

import SwiftUI

struct Day23_2: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            HStack(alignment: .center) {
                Image(systemName: "\(row * 4 + col).circle")
                    .frame(alignment: .center)
                Text("R\(row) : C\(col)")
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct largeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
    }
}

extension View {
    func largeBlueTitleStyle() -> some View {
        modifier(largeBlueTitle())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    // ForEach 지옥
    var body: some View {
        VStack(alignment: .center) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(alignment: .center) {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct Day23_2_Previews: PreviewProvider {
    static var previews: some View {
        Day23_2()
    }
}
