//
//  ViewController.swift
//  studyApp9
//
//  Created by 문종식 on 2020/01/14.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

var Test = JSON()

func requestTTS(text:String){
    let client_id = "7gg4ij966y"
    let client_secret = "8KJLGjW3NHTMzBDPYBxb7IqH4UZSX9xp6o7IGrna"
    let url = "https://naveropenapi.apigw.ntruss.com/voice/v1/tts"
    let parameter:[String:Any] = ["speaker":"mijin", "speed":0, "text":text] // mijin & jinho
    let httpHeaders: HTTPHeaders = [ "X-NCP-APIGW-API-KEY-ID":client_id, "X-NCP-APIGW-API-KEY":client_secret, "Content-Type":"application/x-www-form-urlencoded"]
    let fileName = "css"
    let fileFormat = "mp3"
    
    let DocumentDirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileFormat)
    
    AF.request(url,method: .post, parameters: parameter, headers: httpHeaders).responseData { response in
        let statusCode = response.response?.statusCode
        debugPrint(statusCode as Any)
        if statusCode == 200 {
            do {
                try response.data?.write(to: fileURL)
                debugPrint(response)
            } catch let error as NSError {
                debugPrint("Error: \(error)")
            }
        }
    }
}

func isLogin( ) {
//    // http://203.252.161.219:8080/
//    let url = "http://203.252.161.219:8080/cmmn/isLogin.do"
//    //let url2 = "http://203.252.161.219:8080/login/logs.do"
//    // cmmn/isLogin.do
//    AF.request(url, method: .get).responseString { response in
//        debugPrint(response)
//    }
    
    let client_id = "8HjtiKPIoXC7H8yiXceA"
    let client_secret = "AM1cI6wVv8"
    let url = "https://openapi.naver.com/v1/search/local.json?query=제노PC&display=10&start=10&sort=random"
    let convertURL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    let httpHeaders: HTTPHeaders = [ "X-Naver-Client-Id":client_id, "X-Naver-Client-Secret":client_secret]
    
    AF.request(convertURL, method: .get, headers: httpHeaders).responseString { response in
        debugPrint(JSON(response.value!))
    }
    
}

func appVersionCheckF( ) { // update 필요
    // http://203.252.161.219:8080/
    let url = "http://203.252.161.219:8080/cmmn/appVersionCheck.do"
    // cmmn/isLogin.do
    let body: [String:String] = [
        "appVersion" : "2.0.7"
    ]
    
    AF.request(url, method: .post, parameters: body["appVersion"], encoder: JSONParameterEncoder.default).response { response in
        debugPrint(response)
    }
    //print(AF.request(url, method: .post, parameters: body))
}

func appVersionCheckT( ) { // update 필요
    // http://203.252.161.219:8080/
    let url = "http://203.252.161.219:8080/cmmn/appVersionCheck.do"
    // cmmn/isLogin.do
    let body: [String:String] = [
        "appVersion" : "1.0.0"
    ]
    
    //user/jsonTest.do
    
    AF.request(url, method: .post, parameters: body["appVersion"], encoder: JSONParameterEncoder.default).response { response in
        debugPrint(response)
    }
    //print(AF.request(url, method: .post, parameters: body))
}

func voTest() { // update 필요
    // http://203.252.161.219:8080/
    //let url = "http://192.168.0.202:8000/api/v1/firstAPIs/?format=json"
    //let url = "http://203.252.161.219:8080/user/jsonTest.do"
    let url = "http://203.252.130.194:8080/user/jsonTest.do"
    
    AF.request(url, method: .get).responseJSON
    {
        response in
        debugPrint(JSON(response.value!))
        let jsonTodict = JSON(response.value!)
//        let jsonFirst = JSON(jsonTodict[0])
//        let jsonSecond = JSON(jsonTodict[1])
        Test = JSON(response.value!)
        voTest2()
//        print(jsonTodict)
//        print(jsonFirst)
//        print(jsonSecond)
    }
    print("Ready")
}

func voTest2() {
    print("Go")
    print(Test)
    
    var convertedString = Test.rawString()!
    
    print("####")
    print(convertedString)
    print("###")
    convertedString = convertedString.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    print("##")
    print(convertedString)
    let url = "http://203.252.130.194:8080/user/jsonTest2.do"
    let httpHeaders: HTTPHeaders = ["json":convertedString]

    AF.request(url, method: .post, headers: httpHeaders).responseJSON { response in
        debugPrint(response)
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let text = "가 나 다 라 마 바 사 아 자 차 카 타 파 하"
         //requestTTS(text: text)
    }
    
    // GET
    // 로그인시 1, 아니면 -1
    @IBAction func getFunc(_ sender: Any) {
        //getTest()
        isLogin()
    }
    
    @IBAction func getTrue(_ sender: UIButton) {
        appVersionCheckT()
    }
    
    @IBAction func getFalse(_ sender: UIButton) {
        appVersionCheckF()
    }
    
    @IBAction func testVO(_ sender: UIButton) {
        voTest()
    }
    
    @IBAction func versionGet(_ sender: UIButton) {
        let appVersion = getVersion()
        print(appVersion)
    }
    
    
    func getVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        //print(dictionary)
        
        return version
    }

}

