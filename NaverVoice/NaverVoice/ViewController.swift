//
//  ViewController.swift
//  NaverVoice
//
//  Created by 문종식 on 2020/07/17.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    @IBOutlet var tfText: UITextField!
    @IBOutlet var segVoice: UISegmentedControl!
    @IBOutlet var btnRequestVoiceData: UIButton!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var btnPlayVoice: UIButton!

    
    let clientID = "7gg4ij966y"
    let clientSecretKey = "8KJLGjW3NHTMzBDPYBxb7IqH4UZSX9xp6o7IGrna"
    let URL = "https://naveropenapi.apigw.ntruss.com/voice/v1/tts"
    
    var voice = "mijin"
    var text = "123"
    var audioFile: URL!
    var dataVoice:Data?
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }
    
    @IBAction func checkText(_ sender: UITextField) {
        btnRequestVoiceData.isEnabled = (sender.text != "")
    }
    
    @IBAction func changeSegVoice(_ sender: UISegmentedControl) {
        voice = (sender.selectedSegmentIndex == 0) ? "mijin" : "jinho"
        btnRequestVoiceData.isEnabled = true
    }
    
    @IBAction func requestVoiceData(_ sender: UIButton) {
        lblStatus.text = "대기 중"
        let parameter:[String:Any] = [
            "speaker" : voice,
            "speed" : 0,
            "text" : tfText.text!
        ]
        
        let httpHeaders: HTTPHeaders = [
            "Content-Type":"application/x-www-form-urlencoded",
            "X-NCP-APIGW-API-KEY-ID":clientID,
            "X-NCP-APIGW-API-KEY":clientSecretKey,
        ]
        AF.request(URL,method: .post, parameters: parameter,headers: httpHeaders).responseData { response in
            debugPrint(response)
            if response.response?.statusCode == 200{
                self.dataVoice = response.data
                self.btnRequestVoiceData.isEnabled = false
                self.btnPlayVoice.isEnabled = true
                self.lblStatus.text = "완료!"
            }
        }
    }
    
    @IBAction func playVoice(_ sender: UIButton) {
        btnPlayVoice.isEnabled = false
        do{
            audioPlayer = try AVAudioPlayer(data:dataVoice!)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            lblStatus.text = "재생 중..."
        } catch {
            print(error.localizedDescription)
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayVoice.isEnabled = true
        lblStatus.text = "완료!"
    }
    
}

extension UIViewController
{
    //화면터치로 키보드 내리는 함수
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
        view.removeGestureRecognizer(view.gestureRecognizers!.last!)
    }
}
