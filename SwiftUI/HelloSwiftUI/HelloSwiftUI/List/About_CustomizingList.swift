//
//  About_CustomizingList.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/03.
//

import SwiftUI

struct AboutCustomizingList: View {
    var body: some View {
        VStack {
            List {
                Section() {
                    Text("Hello, List!")
                    Text("List Row Insets")
                        .listRowInsets(.init(top: 0, leading: 100, bottom: 0, trailing: 0))
                    Text("List Row Background")
                        .listRowBackground(Color.yellow)
                    Text("List Row Separator")
                        .listRowSeparator(.hidden)
                    Text("List Row Separator Tint")
                        .listRowSeparatorTint(.red)
                    Text("Temp Row")
                }
                .listRowInsets(.init(top: 0, leading: 60, bottom: 0, trailing: 0))
                .listRowBackground(Color.cyan)
                
                Section() {
                    Text("One")
                    Text("Two")
                }
                
                Section() {
                    Text("Custom Header")
                } header: {
                    CustomHeaderView(title: "Lorem Ipsum", imageName: "star")
                }
            }
//            .listStyle(.sidebar)
            // grouped, plain, insetGrouped(Default), inset(plain에서 inset약간), sidebar
        }
    }
}

struct CustomHeaderView: View {
    let title: String
    let imageName: String
    var body: some View {
        Label(self.title, systemImage: self.imageName)
            .font(.title)
            .frame(minHeight: 60)
    }
}

struct About_CustomizingList_Previews: PreviewProvider {
    static var previews: some View {
        AboutCustomizingList()
    }
}
