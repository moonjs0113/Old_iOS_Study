//
//  Find_ID_PW_ViewController.swift
//  perfectDay0
//
//  Created by 문종식 on 2020/01/21.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class Find_ID_PW_ViewController: UIViewController {

    // Find
    var findID_PW = true
    @IBOutlet var findIDBtn: UIButton!
    @IBOutlet var findPWBtn: UIButton!
    @IBOutlet var findAccountName: UITextField!
    @IBOutlet var findAccountEmail: UITextField!
    @IBOutlet var findAccountPhone: UITextField!
    @IBOutlet var hideField: UIStackView!
    @IBOutlet var findBtn: UIButton!
    
    
    @IBOutlet var idBtn: UIButton!
    @IBOutlet var pwBtn: UIButton!
    @IBOutlet var showInfo: UITextView!
    
    var findIDnPW = true
    var findName = ""
    var findPhone = ""
    var findEmail = ""
    var finded = false
    var restorationID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restorationID = self.restorationIdentifier!
        if String(restorationID) == "findView" {
            findBtn.layer.cornerRadius = 5
            checkEditTextField()
            borderSetFind()
        } else if String(restorationID) == "showIDPW"{
            clearFindView()
            setTextView()
            showIDnPW()
            //########### 디버그 ##########
            print("이름: \(findName)")
            print("핸드폰 번호: \(findPhone)")
            if !findIDnPW {
                print("이메일: \(findEmail)")
            }
        }
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        restorationID = self.restorationIdentifier!
        if finded == true && String(restorationID) == "findView" {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Bye")
    }
    
     // ##################################################
     // #################### 기본 함수 ######################
     // ##################################################
     func setField(_ field: UITextField,_ str: String){
         field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
         field.layer.borderWidth = 1.0
         field.layer.cornerRadius = 5
         field.attributedPlaceholder = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
     }
    
    // ##################################################
    // ############### 아이디/비밀번호 찾기 ##################
    // ##################################################
    
    // TextField 값 변화 감지
    func checkEditTextField(){
        findAccountName.addTarget(self, action: #selector(Find_ID_PW_ViewController.NameFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        findAccountPhone.addTarget(self, action: #selector(Find_ID_PW_ViewController.PhoneFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        findAccountEmail.addTarget(self, action: #selector(Find_ID_PW_ViewController.EmailFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    // 아이디 찾기 눌렀을 때
    @IBAction func findID(_ sender: UIButton) {
        findID_PW = true
        // ID
        findIDBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3647058824, blue: 0.5725490196, alpha: 1)
        findIDBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        findIDBtn.isEnabled = false
        //PW
        findPWBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        findPWBtn.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        findPWBtn.isEnabled = true
        // TextField
        hideField.isHidden = true
        findAccountEmail.text = ""
        checkFind()
    }
    
    @IBAction func findPW(_ sender: UIButton) {
        findID_PW = false
        // ID
        findIDBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        findIDBtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
        findIDBtn.isEnabled = true
        // PW
        
        findPWBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3647058824, blue: 0.5725490196, alpha: 1)
        findPWBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        findPWBtn.isEnabled = false
        // TextField
        hideField.isHidden = false
        checkFind()
    }
    
    func changeFindBtn() {
        if findBtn.isEnabled {
            findBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3647058824, blue: 0.5725490196, alpha: 1)
        } else {
            findBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    func checkFind(){
        //print(findAccountName.isEditing)
        if (findAccountName.text != "") && (findAccountPhone.text != "") {
            if findID_PW {
                findBtn.isEnabled = true
            } else {
                if (findAccountEmail.text != "") {
                    findBtn.isEnabled = true
                } else { findBtn.isEnabled = false }
            }
        } else { findBtn.isEnabled = false }
        changeFindBtn()
    }
    
    @objc func NameFieldDidChange(_ textField: UITextField) {
        checkFind()
    }
    
    @objc func PhoneFieldDidChange(_ textField: UITextField) {
        checkFind()
    }
    
    @objc func EmailFieldDidChange(_ textField: UITextField) {
        checkFind()
    }
    
    func borderSetFind(){
        setField(findAccountName, "홍길동")
        setField(findAccountPhone, "01055879889")
        setField(findAccountEmail, "perfectday@newrun.com")
    }
    
    @IBAction func backFunc(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func gotoInfo(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let goToVC = storyboard.instantiateViewController(withIdentifier: "showIDPW")
        self.present(goToVC, animated: true, completion: nil)
        
        //navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
        finded = true
    }
    
    // ##################################################
    // ############### 아이디/비밀번호 보여주기 ##################
    // ##################################################
    
    func clearFindView(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let clearVC = storyboard.instantiateViewController(withIdentifier: "findView")
        clearVC.navigationController?.popViewController(animated: true)
        clearVC.dismiss(animated: true, completion: nil)
    }
    
    func setTextView() {
        showInfo.layer.borderWidth = 1
        showInfo.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        showInfo.layer.cornerRadius = 5
        showInfo.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func showIDnPW() {
        if !findIDnPW{ // ID 찾기
            // ID
            idBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            idBtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
            // PW
            pwBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3647058824, blue: 0.5725490196, alpha: 1)
            pwBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            showInfo.text = "해당 정보로 가입된 내역이 없습니다.\n다시 한 번 확인해 주세요."
        } else { // PW 찾기
            // ID
            pwBtn.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            pwBtn.setTitleColor(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), for: .normal)
            // PW
            idBtn.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3647058824, blue: 0.5725490196, alpha: 1)
            idBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            showInfo.text = "해당 정보로 가입된 아이디가 없습니다.\n다시 한 번 확인해 주세요."
        }

    }
    
    @IBAction func backLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
