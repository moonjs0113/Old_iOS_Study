//
//  EditViewController.swift
//  studyApp3
//
//  Created by 문종식 on 2020/01/05.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    
    @IBOutlet var wayLb: UILabel!
    var textWayValue: String = ""
    
    @IBOutlet var messageTx: UITextField!
    var textMessage: String = ""
    var delegate : EditDelegate?
    
    @IBOutlet var switchOnOff: UISwitch!
    var isOn = false
    var isZoom = false
    @IBOutlet var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wayLb.text = textWayValue
        // Do any additional setup after loading the view.
        
        messageTx.text = textMessage
        switchOnOff.isOn = isOn
        
    }
    
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
    }
    @IBAction func zoomBtn(_ sender: UIButton) {
        if isZoom {
            isZoom = false
            btnZoom.setTitle("확대", for: .normal)
        } else {
            isZoom = true
            btnZoom.setTitle("축소", for: .normal)
        }
    }
    
    /*
     // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func doneBtn(_ sender: UIButton) {
        // 완료 버튼을 통해 message.text의 String을 메인화면에 전달
        if delegate != nil {
            print(" ")
            print("debug")
            print(" ")
            delegate?.didMessageEditDone(self, message: messageTx.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
}
