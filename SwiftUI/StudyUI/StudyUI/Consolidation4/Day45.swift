//
//  Day45.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/03/18.
//

import SwiftUI

// Animating simple shapes with animatableData
struct Trapezoid: Shape {
    var insetAmount: Double
    var animatableData: Double {
        get { self.insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: self.insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - self.insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct TrapezoidView: View {
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: self.insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
//                self.insetAmount = Double.random(in: 10...90)
                withAnimation{
                    self.insetAmount = Double.random(in: 10...90)
                }
            }
    }
}

// Animating complex shapes with AnimatablePair
struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double,Double> {
        get {
            AnimatablePair(Double(self.rows), Double(self.columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(self.rows)
        let columnSize = rect.height / Double(self.columns)
        
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct CheckerboardView: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: self.rows, columns: self.columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.columns = 16
                }
            }
    }
}

// Creating a spirograph with SwiftUI
struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double

    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = self.gcd(self.innerRadius, self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let outerRadius = Double(self.outerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * self.amount
        
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}

struct SpirographView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Spirograph(innerRadius: Int(self.innerRadius), outerRadius: Int(self.outerRadius), distance: Int(self.distance), amount: self.amount)
                .stroke(Color(hue: self.hue, saturation: 1, brightness: 1), lineWidth: 2)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            Group {
                Text("Inner radius: \(Int(self.innerRadius))")
                Slider(value: self.$innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Outer radius: \(Int(self.outerRadius))")
                Slider(value: self.$outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Distance: \(Int(self.distance))")
                Slider(value: self.$distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: self.$amount)
                    .padding([.horizontal, .bottom])
                
                Text("Color")
                Slider(value: self.$hue)
                    .padding(.horizontal)
            }
        }
    }
}

// Special effects in SwiftUI: blurs, blending, and more
struct Day45: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                Image("PaulHudson")
                
                Rectangle()
                    .fill(.red)
                    .blendMode(.multiply)
            }
            .frame(width: 40, height: 50)
            .clipped()
            
//            Image("PaulHudson")
//                .colorMultiply(.blue)
            
            Image("PaulHudson")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .saturation(self.amount)
                .blur(radius: (1 - self.amount) * 20)
            
            VStack(spacing:15) {
                ZStack {
                    Circle()
                        .fill(.yellow)
                        .frame(width: 200 * self.amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    
                    Circle()
                        .fill(.green)
                        .frame(width: 200 * self.amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)
                    
                    Circle()
                        .fill(.blue)
                        .frame(width: 200 * self.amount)
                        .blendMode(.screen)
                }
                .frame(width: 300, height: 300)
                
                Slider(value: self.$amount)
                    .padding()
                
                NavigationLink("Trapezoid", destination: TrapezoidView())
                NavigationLink("CheckerboardView", destination: CheckerboardView())
                NavigationLink("SpirographView", destination: SpirographView())
            }
            .frame(width: .infinity, height: .infinity)
            .background(.purple)
            .ignoresSafeArea()
        }
        
    }
}

struct Day45_Previews: PreviewProvider {
    static var previews: some View {
        Day45()
    }
}
