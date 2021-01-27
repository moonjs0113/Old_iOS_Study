//
//  Accept_Join_ViewController.swift
//  perfectDay0
//
//  Created by 문종식 on 2020/01/10.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class Accept_Join_ViewController: UIViewController{
    
    // Accept
    @IBOutlet var allAcceptBtn: UIButton!
    @IBOutlet var personalAcceptBtn: UIButton!
    @IBOutlet var LocationAcceptBtn: UIButton!
    @IBOutlet var marketingAcceptBtn: UIButton!
    @IBOutlet var acceptBtn: UIButton!
    
    @IBOutlet var acceptLbl: UILabel!
    @IBOutlet var joinLbl: UILabel!
    
    var checkImageOn = UIImage(named: "check_circle_on")
    var checkImageOff = UIImage(named: "check_circle_off")
    var acceptAarry: Array<Bool> = [false, false, false, false, false]
    
    // Join
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var pwCheckField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var birthField: UITextField!
    @IBOutlet var genderField: UISegmentedControl!
    @IBOutlet var nicknameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    
    var restorationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restorationID = self.restorationIdentifier!
        //print(restorationId)
        if String(restorationID) == "acceptView" {
            acceptLbl.sizeToFit()
        } else if String(restorationID) == "joinView" {
            setScroll()
            borderSetJoin()
        }
        hideKeyboard()
    }

    // ##################################################
    // #################### 기본 함수 ######################
    // ##################################################
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
     */
    func setField(_ field: UITextField,_ str: String){
        field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5
        field.attributedPlaceholder = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
    }
    
    // ##################################################
    // #################### 이용약관 ######################
    // ##################################################
    
    // 동의하기 버튼 활성화 판단
    func isAllAccept() {
        if acceptAarry[1] && acceptAarry[2] {
            acceptAarry[4] = true
            acceptBtn.setImage(UIImage(named: "accept_on"), for: .normal)
            if acceptAarry[3] {
                acceptAarry[0] = true
                allAcceptBtn.setImage(checkImageOn, for: .normal)
            } else {
                acceptAarry[0] = false
                allAcceptBtn.setImage(checkImageOff, for: .normal)
            }
            acceptBtn.isEnabled = true
        } else {
            acceptAarry[0] = false
            acceptAarry[4] = false
            acceptBtn.setImage(UIImage(named: "accept_off"), for: .normal)
            allAcceptBtn.setImage(checkImageOff, for: .normal)
            acceptBtn.isEnabled = false
        }
    }

    
    // 모두 동의 눌렀을 때
    @IBAction func allAccept(_ sender: UIButton) {
        if !acceptAarry[0] { // Off -> On
            allAcceptBtn.setImage(checkImageOn, for: .normal)
            personalAcceptBtn.setImage(checkImageOn, for: .normal)
            LocationAcceptBtn.setImage(checkImageOn, for: .normal)
            marketingAcceptBtn.setImage(checkImageOn, for: .normal)
            for i in 0..<acceptAarry.count-1 {
                acceptAarry[i] = true
            }
        } else{ // On -> Off
            
            allAcceptBtn.setImage(checkImageOff, for: .normal)
            personalAcceptBtn.setImage(checkImageOff, for: .normal)
            LocationAcceptBtn.setImage(checkImageOff, for: .normal)
            marketingAcceptBtn.setImage(checkImageOff, for: .normal)
            for i in 0..<acceptAarry.count-1 {
                acceptAarry[i] = false
            }
        }
        isAllAccept()
    }
    
    // 체크박스 이벤트
    func acceptFunc(_ Btn: UIButton, index: Int) {
        if !acceptAarry[index] { // Off -> On
            Btn.setImage(checkImageOn, for: .normal)
            acceptAarry[index] = true
        } else { // On -> Off
            Btn.setImage(checkImageOff, for: .normal)
            acceptAarry[index] = false
        }
    }
    
    // 개인정보 동의 눌렀을 때
    @IBAction func personalAccept(_ sender: UIButton) {
        acceptFunc(personalAcceptBtn, index: 1)
        isAllAccept()
    }
    
    // 위치 정보 활용 동의 눌렀을 때
    @IBAction func LocationAccept(_ sender: UIButton) {
        acceptFunc(LocationAcceptBtn, index: 2)
        isAllAccept()
    }
    
    // 마케팅 정보 수신 동의 눌렀을 때
    @IBAction func marketingAccept(_ sender: UIButton) {
        acceptFunc(marketingAcceptBtn, index: 3)
        isAllAccept()
    }
    
    @IBAction func startJoin(_ sender: UIButton) {
        
    }
    
    
    
    // ##################################################
    // #################### 회원 가입 ######################
    // ##################################################
    func setScroll() {
        //scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        /*
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        //view.widthAnchor
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         */
    }
    func borderSetJoin(){
        setField(emailField,"이메일")
        setField(pwField, "영문, 숫자 포함 8 - 10자")
        setField(pwCheckField, "영문, 숫자 포함 8 - 10자")
        setField(nameField,"홍길동")
        setField(birthField, "YYYYMMDD ex)19980113")
        setField(nicknameField, "한글, 영문, 숫자 10자 이내")
        setField(phoneField, "01055879889")
    }
}



