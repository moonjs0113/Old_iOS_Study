//
//  ShapesDrawingGraphics.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/24.
//

import SwiftUI

struct Shapes: View {
    var body: some View {
                ScrollView {
        VStack {
            VStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 300, height: 40)
                RoundedRectangle(cornerRadius: 15, style: .circular)
                    .fill(.orange)
                    .frame(width: 290, height: 40)
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.yellow)
                    .frame(width: 280, height: 40)
                Circle()
                    .fill(.green)
                    .frame(width: 270, height: 30)
                Ellipse()
                    .fill(.blue)
                    .frame(width: 260, height: 40)
                Capsule(style: .circular)
                    .fill(.indigo)
                    .frame(width: 250, height: 40)
                Capsule(style: .continuous)
                    .fill(.purple)
                    .frame(width: 240, height: 40)
            }
            VStack {
                ScaledShape(shape: Rectangle(),
                            scale: CGSize(width: 10, height: 4))
                .fill(.pink)
                .frame(width: 23, height: 10)
                .padding()
                RotatedShape(shape: Capsule(style: .continuous),
                             angle: .radians(0.4))
                .fill(.mint)
                .frame(width: 220, height: 40)
                OffsetShape(shape: Ellipse(),
                            offset: CGSize(width: 50, height: 10))
                .fill(.cyan)
                .frame(width: 210, height: 40)
                TransformedShape(shape: RoundedRectangle(cornerRadius: 15, style: .circular),
                                 transform: CGAffineTransform(a: -0.2, b: -0.3, c: 6, d: 1, tx: 0, ty: 0))
                .fill(.teal)
                .frame(width: 200, height: 40)
            }
        }
                }
                .onAppear {
                    print(#file)
                    print(#function)
                    if let bundlePath = Bundle.main.url(forResource: "Shapes", withExtension: "swift") {
                        print(bundlePath)
                        let jsonData = try? Data(contentsOf: bundlePath)
                        print(jsonData?.base64EncodedString())
                    }
                }
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
