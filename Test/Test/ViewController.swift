//
//  ViewController.swift
//  Test
//
//  Created by 문종식 on 2020/12/18.
//

import UIKit

class ViewController: UIViewController {

    var card: UIView!
    
    // MARK: - Methods
    func makeButton() -> UIButton {
        let button = UIButton()
        button.frame.size.width = 50
        button.frame.size.height = 20
        button.setTitle("button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        
        return button
    }
    
    func makeCard() -> UIView {
        let view = UIView()
        view.frame.size.width = self.view.frame.size.width * (9 / 10)
        view.frame.size.height = self.view.frame.size.height * (1 / 2)
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        let button = makeButton()
        button.center = view.center
        button.addTarget(self, action: #selector(upCornerRadius(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        return view
    }
    
    // MARK: - IBOutlets
    
    // MARK: - IBActions
    @objc func upCornerRadius(_ sender: UIButton!) {
        self.card.layer.cornerRadius += 5
    }
    
    // MARK: - Delegates And DataSource
    
    func Test(){
        self.view.backgroundColor = .blue
        
        self.card = makeCard()
        card.center = self.view.center
        
        self.view.addSubview(self.card)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test()
//        createCardViewMe()
    }
    
    func createCardViewMe() {
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let card:UIView = {
            let view = UIView(frame: self.view.frame)
            view.backgroundColor = .white
            view.layer.cornerRadius = 15
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
            return view
        }()
        
        let button:UIButton = {
            let btn = UIButton()
            btn.setTitle("button", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.setTitleColor(.lightGray, for: .highlighted)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(touch(_:)), for: .touchUpInside)
            card.addSubview(btn)
            return btn
        }()
        
        NSLayoutConstraint.activate([
            card.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2),
            card.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            card.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: card.centerXAnchor)
        ])
    }
    
    @objc func touch(_ sender : UIButton) {
        sender.superview?.layer.cornerRadius += 10
    }


}

