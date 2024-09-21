//
//  SwiftUIView.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        SwiftUIViewController()
    }
}

struct SwiftUIViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIHostingController<NetworkView>
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return UIHostingController(rootView: NetworkView())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
