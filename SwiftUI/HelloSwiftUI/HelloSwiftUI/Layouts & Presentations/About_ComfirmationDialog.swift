//
//  About_ComfirmationDialog.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

// ComfirmationDialog
// iOS에서는 Bottom Alert으로 나타난다.
// iPadOS에서는 Popup 형태(iOS의 Menu 형태)로 나타난다.
struct AboutComfirmationDialog: View {
    @State private var showDialog: Bool = false
    @State private var showDialogFromData: Bool = false
    @State private var color: Color = .black
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
            
            Button {
                self.showDialogFromData.toggle()
            } label: {
                Text("Select Color From Data")
            }
            .confirmationDialog("컬러 선택 for Data",
                                isPresented: self.$showDialogFromData,
                                presenting: ColorData.samples) { colors in
                ForEach(colors) { color in
                    Button(color.title) {
                        self.color = color.color
                    }
                }
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                
                Button(role: .destructive) {
                    self.color = .black
                } label: {
                    Text("Reset")
                }
            }
            
            Button {
                self.showDialog.toggle()
            } label: {
                Text("Select Color")
            }
            .confirmationDialog("컬러선택", isPresented: $showDialog) {
                Button("Red") {
                    self.color = .red
                }
                
                Button("Green") {
                    self.color = .green
                }
                
                Button("Blue") {
                    self.color = .blue
                }
                
                Button(role: .cancel) {
                    
                } label: {
                    Text("Cancel")
                }
                
                Button(role: .destructive) {
                    self.color = .black
                } label: {
                    Text("Reset")
                }
            } message: {
                Text("원하는 컬러를 선택해주세요.")
            }
        }
    }
}

struct ColorData: Identifiable {
    var id: String {
        return title
    }
    let title: String
    let color: Color
    
    static let samples = [
        ColorData(title: "Red", color: .red),
        ColorData(title: "Green", color: .green),
        ColorData(title: "Blue", color: .blue),
        ColorData(title: "Yellow", color: .yellow),
        ColorData(title: "Pink", color: .pink)
    ]
}

struct About_ComfirmationDialog_Previews: PreviewProvider {
    static var previews: some View {
        AboutComfirmationDialog()
    }
}
