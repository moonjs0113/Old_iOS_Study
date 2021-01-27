//
//  ViewController.swift
//  NetworkTest
//
//  Created by 문종식 on 2020/03/26.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

let serverIP = "http://203.252.161.219:8080"
let developIP = "http://203.252.130.194:8080"

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnLoginUser(_ sender: UIButton) {
        let url = developIP + "/user/loginUser.do"
//        let url = serverIP + "/user/loginUser.do"
        let jsonHeader = JSON(["userSn":"_","deviceOS":"IOS"])
        
        let parameter = JSON([
            "userEmail":"hogafol284@windmails.net",
            "userPw":"0000".sha256(),
            "loginType":"001",
        ])
        let convertedParameterString = parameter.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let convertedString = jsonHeader.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let httpHeaders: HTTPHeaders = ["json":convertedString]
        
        AF.request(url,method: .post, parameters: ["json":convertedParameterString], headers: httpHeaders).responseJSON { response in
            debugPrint(response)
            self.debugLine()
        }
    }
    
    @IBAction func btnRetrieveUserName(_ sender: UIButton) {
        let url = developIP + "/user/retrieveUserName.do"
//        let url = serverIP + "/user/retrieveUserName.do"
        let jsonHeader = JSON(["userSn":"_","deviceOS":"IOS"])
        let parameter: [String:String] = [
            "userName":"Bee",
        ]
        let convertedString = jsonHeader.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let httpHeaders: HTTPHeaders = ["json":convertedString]
        
        AF.request(url,method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: httpHeaders).responseJSON { response in
            debugPrint(response)
            debugPrint(JSON(response.value!))
            self.debugLine()
        }
    }
    
    // 성공 코드
    @IBAction func btnFindUserEmail(_ sender: UIButton) {
        let url = developIP + "/user/findUserEmail.do"
//        let url = serverIP + "/user/findUserEmail.do"
        let jsonHeader = JSON([
            "userSn":"_",
            "deviceOS":"IOS"
        ])
        let jsonParameter = JSON([
            "userRealName": "Bee",
            "userGender": "001",
            "birthDt": "19970619",
        ])
        let convertedParameterString = jsonParameter.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let convertedHeaderString = jsonHeader.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        print(convertedParameterString)
        print(String(jsonParameter.rawString()!))
        let httpHeaders: HTTPHeaders = ["json":convertedHeaderString]
//        , encoder: JSONParameterEncoder.default
        AF.request(url,method: .post, parameters: ["json":convertedParameterString], headers: httpHeaders).responseJSON { response in
            debugPrint(response)
            debugPrint(JSON(response.value!))
            self.debugLine()
        }
    }
    
    @IBAction func btnResetUserPassword(_ sender: UIButton) {
        let url2 = developIP + "/user/resetUserPassword.do"
//        let url = serverIP + "/user/loginUser.do"
        let jsonHeader = JSON(["userSn":"_","deviceOS":"IOS"])
        let parameter2 = JSON([
            "userEmail":"hogafol284@windmails.net",
            "userRealName":"Bee",
            "userGender":"001",
            "birthDt":"19970619",
        ])
        let convertedParameterString = parameter2.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let convertedString = jsonHeader.rawString()!.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        let httpHeaders: HTTPHeaders = ["json":convertedString]
        
        AF.request(url2,method: .post, parameters: ["json":convertedParameterString], headers: httpHeaders).responseJSON { response in
            debugPrint(response)
            self.debugLine()
        }
        
    }
    func debugLine(){
        print("")
        print("######################")
        print("")
    }
}


