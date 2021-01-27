//
//  ViewController.swift
//  perfectDay
//
//  Created by 문종식 on 2020/01/07.
//  Copyright © 2020 NewRun. All rights reserved.
//

import UIKit
import Alamofire

let base_URL = "http://203.252.161.219:8080/"

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.7135855556, blue: 0.8178661466, alpha: 1) // #FFBAD0(255,186,208)
        
    }
}

// 화면터치로 키보드 내리는 함수 
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

