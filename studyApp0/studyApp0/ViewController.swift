//
//  ViewController.swift
//  studyApp0
//
//  Created by 문종식 on 2020/01/03.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    var index: Int = 0
    var flower =  [UIImage?]()
    
    let timeSelector: Selector = #selector(ViewController.updateTime) // Timer function
    let interval = 1.0 // Timer 간격
    var count = 0 // Timer 검증
    var alarmTime: String? // 초기값이 없는 변수를 선언할 경우, ?나 !를 꼭 붙여주는 것이 좋음.
    
    // IB : Interface Builder
    // Strong/Weak : 메모리 회수 정
    // Strong : 다른 곳에서 참조 중인 경우,  메모리에서 제거되지 않음
    // Weak : 다른 곳에서 참조하고 있더라도, 시스템에서 임의로 메모리에서 제거가 가능
    @IBOutlet var changeLb: UILabel!
    @IBOutlet var sendText: UITextField!
    @IBOutlet var clearBtn: UIButton!
    @IBOutlet var sendBtn: UIButton!
    
    @IBOutlet var imgView: UIImageView! // light
    @IBOutlet var plusminusBtn: UIButton!

    @IBOutlet var flowerView: UIImageView!

    @IBOutlet var currentTime: UILabel!
    @IBOutlet var selectTime: UILabel!
    
    
    // viewDidLoad() -> 뷰가 실행되었을 때 호출되는 함수.
    // 뷰가 불러진 후 실행할 기능들을 넣음.
    override func viewDidLoad() {
        super.viewDidLoad()
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        imgView.image = imgOn
        flower = [
            UIImage(named: "1.png"),
            UIImage(named: "2.png"),
            UIImage(named: "3.png"),
            UIImage(named: "4.png"),
            UIImage(named: "5.png"),
            UIImage(named: "6.png")
        ]
        flowerView.image = flower[index]
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    // IBOUtlet 오류 ViewContoller에서 경고 오브젝트 연결 끊기
    @IBAction func send(_ sender: Any) {
        changeLb.text = "Send MSG: " + sendText.text!

        // sendText.text! -> 옵셔널 변수 언래핑
        // 옵셔널 변수(Optionals Variable): 값이 nil이거나, 존재 여부를 알 수 없다는 것을 의미
        // ? -> 초기값을 주지 않았기 때문에 값이 없을 수 있다.
        // ! -> ?로 옵셔널에 래핑(wrapped)된 변수에 접근할 때 사용(강제 언래핑, force unwrapping)
    }
    
    @IBAction func clear(_ sender: Any) {
        changeLb.text = "Hello, World"
    }
    
    @IBAction func changeImgSize(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight: CGFloat
        var xLocation:CGFloat, yLocation: CGFloat
        
        // UIImage 객체 속성 확인 frame, center
        if (isZoom){
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            plusminusBtn.setTitle("Plus", for: .normal)
            xLocation = imgView.center.x
            yLocation = imgView.center.y + (newHeight/scale)

        } else{
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            plusminusBtn.setTitle("Minus", for: .normal)
            xLocation = imgView.center.x
            yLocation = imgView.center.y - (imgView.frame.height/scale)
        }
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        imgView.center.x = xLocation
        imgView.center.y = yLocation
        
        isZoom = !isZoom
    }
    
    
    @IBAction func switchOnOff(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
    }
    
    @IBAction func preFlower(_ sender: UIButton) {
        if(index != 0){
            index -= 1
            flowerView.image = flower[index]
        }
    }
    
    @IBAction func nextFlower(_ sender: UIButton) {
        if(index != flower.count-1){
            index += 1
            flowerView.image = flower[index]
        }
    }
    
    @IBAction func changeTime(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter()
        // DateFormatter의 포맷 설정 -> .dateFormat
        formatter.dateFormat = "HH:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        selectTime.text = "  Select Time: " + formatter.string(from: datePickerView.date)
    }
    
    @objc func updateTime(){
        //currentTime.text = String(count)
        //count += 1
        let date = NSDate() // 현재 시간 출력함수
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm aaa"
        let compareTime = formatter.string(from: date as Date)
        
        if(compareTime == alarmTime) {
            view.backgroundColor = UIColor.red // 백그라운드 컬러 바꾸기
        } else {
            view.backgroundColor = UIColor.white
        }
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        currentTime.text = "  Current Time: " + formatter.string(from: date as Date)
    }
    
}

