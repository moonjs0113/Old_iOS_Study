//
//  ViewController.swift
//  studyApp1
//
//  Created by 문종식 on 2020/01/03.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, WKNavigationDelegate{
    
    // 5장
    @IBOutlet var imagePicker: UIPickerView!
    // Picker -> 델리게이트(Delegate) method를 사용해야함.
    // 사용하기 위해선 UIPickerViewDelegate, UIPickerViewDataSource 를 상속받아야함.
    @IBOutlet var imageLb: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageLb2: UILabel!
    @IBOutlet var imageView2: UIImageView!
    
    var imageFiles = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg",
                    "6.jpg","7.jpg","8.jpg","9.jpg","10.jpg",]
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 2
    var imageArray = [UIImage?]()
    
    // 6장
    @IBOutlet var imageLight: UIImageView!
    @IBOutlet var existBtn: UIButton!
    
    let lightOn = UIImage(named: "lamp-on.png")
    let lightOff = UIImage(named: "lamp-off.png")
    let lightRemove = UIImage(named: "lamp-remove.png")
    var lightOnOff = true
    var lightExist = true
    
    // 7장
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 5장
        // for i in 0...NUM {,} -> 0 ~ NUM Loof
        // for i in 0..<NUM {,} -> 0 ~ NUM-1 Loof
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFiles[i])
            imageArray.append(image)
        }
        imageLb.text = imageFiles[0]
        imageView.image = imageArray[0]
        
        imageLb2.text = imageFiles[0]
        imageView2.image = imageArray[0]
        
        // 6장
        imageLight.image = lightOn
        
        // 7장
        webView.navigationDelegate = self
        // Info.plist -> Information Property List + ->
        // App Transport Security Settings + -> Allow Arbitrary Loads -> YES
        loadWebPage("http://www.naver.com")
    }
    
    // 5장
    // PickerView에게 Component의 수를 정수 값으로 넘겨줌
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    
    // PickerView에게 Component의 열의 개수를 정수 값으로 넘겨줌 -> PickerView에서 선택할 수 있는 데이터의 개수
    // titleForRow, didSelectRow row 등에 활용되는 듯
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageFiles.count
    }
    
    // PickerView에게 Component의 각 타이틀을 값으로 넘겨줌(선택된 Component)
    //func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return imageFiles[row]
    //}
    
    // PickerView에서 선택된 값 전달
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if (component == 0){
            imageLb.text = imageFiles[row]
            imageView.image = imageArray[row]
        } else {
            imageLb2.text = imageFiles[row]
            imageView2.image = imageArray[row]
        }
    }
    
    // PickerView에서 중앙에 표시될 값 속성
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        
        return imageView
    }
    
    // 6장
    @IBAction func onLight(_ sender: UIButton) {
        if lightExist {
            if lightOnOff {
                // Alert Main variable
                // title -> Alert 제목
                // message -> 내용
                // preferredStyle -> alert: 중앙 팝업 선택지 가로 나열, actionSheet: 아래 팝업 선택지 세로 나열
                let lampOnAlert = UIAlertController(title: "알림",
                                                    message: "현재 On 상태입니다.\n램프를 끄시겠습니다.",
                                                    preferredStyle: UIAlertController.Style.actionSheet)
                // Alert Action Fucntion
                // title ->  선택지 문구
                // style -> default: 기본, cancel: 선택 우선순위 부여 + 굵은 글씨, destructive: 붉은색
                // handler -> Detail Function
                let onAction = UIAlertAction(title: "Yes",
                                             style: UIAlertAction.Style.default,
                                             handler: {
                                                Action in self.imageLight.image = self.lightOff
                                                self.lightOnOff = false
                })
                let cancelAction = UIAlertAction(title: "No",
                                                 style: UIAlertAction.Style.default,
                                              handler: nil)
                
                // Alert Action 추가
                lampOnAlert.addAction(onAction)
                lampOnAlert.addAction(cancelAction)
                
                // Alert 표시
                present(lampOnAlert, animated: true, completion: nil)
            } else {
                let lampOnAlert = UIAlertController(title: "램프 켜기",
                                                    message: "램프를 켜시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let offAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightOn
                                                self.lightOnOff = true
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
                
                lampOnAlert.addAction(offAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
            }
        } else {
            let lampOnAlert = UIAlertController(title: "알림",
                                                message: "램프가 없습니다.\n사용하시겠습니까?",
                                                preferredStyle: UIAlertController.Style.alert)
            let offAction = UIAlertAction(title: "Yes",
                                          style: UIAlertAction.Style.default,
                                          handler: {
                                            Action in self.imageLight.image = self.lightOff
                                            self.lightOnOff = false
                                            self.lightExist = true
                                            self.existBtn.setTitle("Remove",for: .normal)
            })
            let cancelAction = UIAlertAction(title: "No",
                                          style: UIAlertAction.Style.default,
                                          handler: nil)
            
            lampOnAlert.addAction(offAction)
            lampOnAlert.addAction(cancelAction)
            
            present(lampOnAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func offLight(_ sender: Any) {
        if lightExist{
            if lightOnOff {
                let lampOnAlert = UIAlertController(title: "램프 끄기",
                                                    message: "램프를 끄시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let offAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightOff
                                                self.lightOnOff = false
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
                
                lampOnAlert.addAction(offAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
            } else {
                let lampOnAlert = UIAlertController(title: "알림",
                                                    message: "현재 Off 상태입니다.\n램프를 켜시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightOn
                                                self.lightOnOff = true
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
                lampOnAlert.addAction(onAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
            }
        } else {
                let lampOnAlert = UIAlertController(title: "알림",
                                                    message: "램프가 없습니다.\n사용하시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let offAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightOff
                                                self.lightOnOff = false
                                                self.lightExist = true
                                                self.existBtn.setTitle("Remove",for: .normal)
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
                
                lampOnAlert.addAction(offAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func existLight(_ sender: Any) {
        if lightExist {
                let lampOnAlert = UIAlertController(title: "알림",
                                                    message: "램프를 제거하시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let offAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightRemove
                                                self.lightOnOff = false
                                                self.lightExist = false
                                                self.existBtn.setTitle("Use",for: .normal)
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
                
                lampOnAlert.addAction(offAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
            } else {
                let lampOnAlert = UIAlertController(title: "알림",
                                                    message: "램프를 사용하시겠습니까?",
                                                    preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "Yes",
                                              style: UIAlertAction.Style.default,
                                              handler: {
                                                Action in self.imageLight.image = self.lightOff
                                                self.lightOnOff = false
                                                self.lightExist = true
                                                self.existBtn.setTitle("Remove",for: .normal)
                })
                let cancelAction = UIAlertAction(title: "No",
                                              style: UIAlertAction.Style.default,
                                              handler: nil)
            
                lampOnAlert.addAction(onAction)
                lampOnAlert.addAction(cancelAction)
                
                present(lampOnAlert, animated: true, completion: nil)
            }
    }
    
    // 7장
    // 로딩 중에 Indicator 보이기
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    // 로딩 끝나면 Indicator 숨기기
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    // 로딩 실패 시, Indicator 숨기기
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // 웹페이지 Request Fucntion
    func loadWebPage(_ url: String) {
        let Url = URL(string: url)
        let Request = URLRequest(url: Url!)
        webView.load(Request)
    }
    
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://") // http:// 로 시작하는지 판별 있-T, 없-F
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func gotoUrlBtn(_ sender: Any) {
        let Url = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(Url)
    }
    
    @IBAction func site1Btn(_ sender: UIButton) {
        loadWebPage("https://www.apple.com/")
    }
    
    @IBAction func site2Btn(_ sender: Any) {
        loadWebPage("https://www.pikicast.com/")
    }
    
    @IBAction func loadHtmlbtn(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func loadHtmlFileBtn(_ sender: Any) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let Url = URL(fileURLWithPath: filePath!)
        let Request = URLRequest(url: Url)
        webView.load(Request)
    }
    
    @IBAction func stopBtn(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    @IBAction func refreshBtn(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func rewindBtn(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardBtn(_ sender: Any) {
        webView.goForward()
    }
}

