//
//  ViewController.swift
//  studyApp3
//
//  Created by 문종식 on 2020/01/05.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

// EditViewController에서 작성한 protocol을 추가
// 오류 발생 시, 오류 확인 -> Fix -> 함수생성(protocol 함수)
class ViewController: UIViewController, EditDelegate{

    @IBOutlet var messageTx: UITextField!
    @IBOutlet var imgView: UIImageView!
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isZoom = false
    var isOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        // segue.indentifier -> 스토리보드 화살표(노드) segue Indentifier 명
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue : Use Button"
        } else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : Use Bar Button"
        }
        editViewController.textMessage = messageTx.text! // 메인화면 문구를 수정화면으로 전달
        editViewController.isOn = isOn
        editViewController.delegate = self
        
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        messageTx.text = message // 수정화면 문구를 메인화면으로 전달
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight: CGFloat
        
        if isZoom {
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
        } else {
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
        }
        
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
    }
}



