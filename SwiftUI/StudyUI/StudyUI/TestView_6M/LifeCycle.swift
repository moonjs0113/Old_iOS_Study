//
//  LifeCycle.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/06/18.
//

import SwiftUI

extension Notification.Name {
    static let taskAddedNotification = Notification.Name("TaskAddedNotification")
}


struct LifeCycle: View {
    @State private var receiveText: String = ""
    @State private var buttonText: String = ""
    @State private var hiddenText: String = ""
    @State private var text: String = ""
    
    
    var body: some View {
        VStack {
            VStack {
                Button("Post Notification") {
                    NotificationCenter.default.post(name: Notification.Name.taskAddedNotification, object: "Task Added Notification Object")
                }
                Text("\(receiveText)")
                Divider()
            }
            
            VStack {
                Button("Button Text Change") {
                    buttonText = "Button Touch!"
                }
                Text("\(buttonText)")
                Divider()
            }
            
            VStack {
                Button {
                    hiddenText = "Button Hidden Touch!"
                } label: {
                    Button {
                        hiddenText = "Button Hidden Touch!"
                    } label: {
                        Button {
                            hiddenText = "Button Hidden Touch!"
                        } label: {
                         Text("asdf")
                        }
                    }
                }
                Divider()
            }
            
            VStack {
                TextField("Text", text: $text)
                Text("\(text)")
                Divider()
            }
            
            NavigationLink("Navi Link") {
                AVPlayer()
            }
        }
        .padding()
        .onAppear {
            print(">>>>>>>>>>>>>>>>>>>>")
            print("onAppear")
            print(">>>>>>>>>>>>>>>>>>>>\n")
        }
        .onDisappear{
            print("<<<<<<<<<<<<<<<<<<<<")
            print("onDisappear")
            print("<<<<<<<<<<<<<<<<<<<<\n")
        }
        .onChange(of: buttonText) { value in
            print("Button Text: \(buttonText)")
            print("onChange Button Value: \(value)")
        }
        .onChange(of: text) { value in
            print("Text: \(text)")
            print("onChange Value: \(value)")
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.taskAddedNotification)) { output in
            receiveText = output.object as? String ?? ""
            print("onReceive: \(receiveText)")
        }
        
    }
}

struct LifeCycle_Previews: PreviewProvider {
    static var previews: some View {
        LifeCycle()
    }
}
