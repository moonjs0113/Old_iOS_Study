//
//  LoginViewController.swift
//  perfectDay
//
//  Created by 문종식 on 2020/01/07.
//  Copyright © 2020 NewRun. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var idTextfield: UITextField!
    @IBOutlet var pwTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setField(idTextfield,"이메일")
        setField(pwTextfield,"비밀번호")
        // Do any additional setup after loading the view.
    }
    
    func setField(_ field: UITextField,_ str: String){
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5
        field.attributedPlaceholder = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
    }
    
    @IBAction func isLogin(_ sender: UIButton) {
        let ID = idTextfield.text!
        let PW = pwTextfield.text!
        let loginInfo: (String, String) = (ID, PW)
        print(loginInfo)
    }

}
