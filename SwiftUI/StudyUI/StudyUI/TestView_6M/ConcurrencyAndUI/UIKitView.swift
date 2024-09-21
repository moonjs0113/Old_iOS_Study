//
//  UIKitView.swift
//  Concurrency
//
//  Created by Moon Jongseek on 2022/06/30.
//

import SwiftUI

struct UIKitView: View {
    var body: some View {
        UIKitViewController()
    }
}

struct UIKitViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

class ViewController: UIViewController {
    
    func setLabel() {
        let uiLabel = UILabel()
        uiLabel.text = "UI Label"
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uiLabel)
        NSLayoutConstraint.activate([
            uiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLabel()
    }
}

struct UIKitView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitView()
    }
}
