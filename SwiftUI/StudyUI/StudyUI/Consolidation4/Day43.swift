//
//  Day43.swift
//  StudyUI
//
//  Created by 문종식 on 2022/03/16.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmlunt = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = self.startAngle - rotationAdjustment
        let modifiedEnd = self.endAngle - rotationAdjustment
        
        var path = Path()
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: self.clockwise)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - self.insetAmlunt, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !self.clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmlunt += amount
        return arc
    }
}



struct Day43: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 100))
                        path.addLine(to: CGPoint(x: 100, y: 300))
                        path.addLine(to: CGPoint(x: 300, y: 300))
                        path.addLine(to: CGPoint(x: 200, y: 100))
                        // 선 끝부분 붙여줌
                        path.closeSubpath()
                    }
            //        .fill(.blue)
            //        .stroke(.blue, lineWidth: 10)
                    .stroke(.black, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    
                    Circle()
                        .stroke(.green, lineWidth: 40)
                    
                    Circle()
                        .strokeBorder(.green, lineWidth: 40)
                    
                    Triangle()
                        .fill(.red)
                        .frame(width: 30, height: 30)
                    
                    Triangle()
                        .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .frame(width: 25, height: 25)
                    
                    Arc(startAngle: .degrees(0), endAngle: .degrees(100), clockwise: true)
                        .stroke(.blue, lineWidth: 10)
                        .frame(width: 100, height: 100)
                    
                    Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                        .stroke(.blue, lineWidth: 5)
                }
                
                NavigationLink("Day44", destination: Day44())
                NavigationLink("Day45", destination: Day45())
            }
        }
    }
}

struct Day43_Previews: PreviewProvider {
    static var previews: some View {
        Day43()
    }
}
