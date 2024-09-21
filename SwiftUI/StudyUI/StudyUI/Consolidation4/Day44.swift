//
//  Day44.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/17.
//

import SwiftUI

struct Day44: View {
    var body: some View {
        VStack {
            NavigationLink("FlowerView", destination: TextDay44View())
            NavigationLink("FlowerView", destination: FlowerView())
            NavigationLink("ColorCyclingCircle", destination: ContentViewDay44())
        }
    }
}

struct TextDay44View: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .frame(width: 300, height: 50)
                .background(.cyan)
            
            Text("Hello World")
                .frame(width: 300, height: 50)
                .border(.red, width: 10)
            
            Text("Hello World")
                .frame(width: 300, height: 50)
                .background(Image("apollo14"))
            
            //                    Text("Hello World")
            //                        .frame(width: 300, height: 50)
            //                        .border(Image("apollo14"), width: 10)
            
            Text("Hello World")
                .frame(width: 300, height: 10)
                .border(ImagePaint(image: Image("apollo14"), scale: 0.2), width: 10)
            
            Text("Hello World")
                .frame(width: 300, height: 30)
                .border(ImagePaint(image: Image("apollo14"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.2), width: 10)
            
            
            //                Capsule()
            //                    .strokeBorder(ImagePaint(image: Image("apollo14"), scale: 0.1), lineWidth: 5)
            //                    .frame(width: 300, height: 20)
            
        }
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.height / 2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct FlowerView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: self.petalOffset, petalWidth: self.petalWidth)
            //                        .stroke(.yellow, lineWidth: 1)
                .fill(.brown, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: self.$petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: self.$petalWidth, in: 0...100)
                .padding([.horizontal])
        }
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<self.steps) { value in
                Circle()
                    .inset(by: Double(value))
                //                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentViewDay44: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 400)
            
            Slider(value: self.$colorCycle)
        }
    }
}

// "apollo14"
struct Day44_Previews: PreviewProvider {
    static var previews: some View {
        Day44()
    }
}
