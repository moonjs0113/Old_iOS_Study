//
//  About_Sheet.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

struct AboutSheet: View {
    @State private var presentCardModal = false
    @State private var presentFullscreen = false
    @State private var colorData: ColorData?
    
    var body: some View {
        VStack {
            Button {
                self.presentCardModal.toggle()
            } label: {
                Text("Card Modal")
            }
            .padding()
            .sheet(isPresented: self.$presentCardModal) {
                // onDismiss
            } content: {
                SheetView(presentModal: self.$presentCardModal)
            }
            
            Button {
                self.presentFullscreen.toggle()
            } label: {
                Text("Fullscreen")
            }
            .padding()
            .fullScreenCover(isPresented: self.$presentFullscreen) {
                // onDismiss
            } content: {
                SheetView(presentModal: self.$presentFullscreen)
            }
            
            // Sheet의 item이 nil이 아닐때 띄운다.
            Button {
                self.colorData = ColorData.samples.first
            } label: {
                Text("Sheet with Item")
            }
            .padding()
            .sheet(item: self.$colorData) {
                // onDismiss
            } content: { color in
                SheetView(presentModal: self.$presentFullscreen)
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var presentModal: Bool
    
    var body: some View {
        
        Button("Close View using presentationMode") {
            self.presentationMode.wrappedValue.dismiss()
        }
        
        Button("Close View using dismiss") {
            self.dismiss()
        }
        
        Button("Close View using Binding") {
            self.presentModal.toggle()
        }
    }
}

struct About_Sheet_Previews: PreviewProvider {
    //
    // .content(value)
    static var previews: some View {
        AboutSheet()
    }
}
