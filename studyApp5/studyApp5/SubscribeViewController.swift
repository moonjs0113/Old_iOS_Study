//
//  SubscribeViewController.swift
//  studyApp5
//
//  Created by 문종식 on 2020/01/07.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {

    
    // 1. StoryBoard 생성
    // 2. 안에 ViewController 생성
    // 3. ViewController - 속성 - Identity - StoryBoardID 설정
    // 4. Main.storyboard에 StoryBoard Reference 생성
    // 5. StoryBoard Reference 속성 - Identity StoryBoardId 설정(3번설정과 동일하게)
    // 6. StoryBoard Reference 속성 - StoryBoard Reference StoryBoard(스토리보드 파일과 연결), ReferenceID(StoryBoardID 설정) 설정
    // 7. ViewController.swift 생성 - 새로 만든 StoryBoard의 ViewController와 연결
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeview(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
