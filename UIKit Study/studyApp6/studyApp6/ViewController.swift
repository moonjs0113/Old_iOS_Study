//
//  ViewController.swift
//  studyApp6
//
//  Created by 문종식 on 2020/01/08.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 기기마다 화면 크기 & Safe Area가 다르다.
    // 각 객체의 제약 조건을 조절하여 레이아웃을 배치할 수 있다.
    // Safe Area에 대한 설정은 각 객체 속성에서 할 수 있다.
    // Safe Area -> 기기마다 영역이 다름
    // Superview -> 어떤에 상관없이 화면 전체
    
    @IBOutlet var layoutView: UIImageView!
    var layoutViewImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViewImg = UIImage(named: "01.png")
        layoutView.image = layoutViewImg
        
        // Do any additional setup after loading the view.
    }
}

