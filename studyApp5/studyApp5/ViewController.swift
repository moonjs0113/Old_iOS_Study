//
//  ViewController.swift
//  studyApp5
//
//  Created by 문종식 on 2020/01/07.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.7135855556, blue: 0.8178661466, alpha: 1) // #FFBAD0(255,186,208)
        // Do any additional setup after loading the view.
        let subVC = SubscribeViewController()
        subVC.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func alertBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Next", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        let subVC = SubscribeViewController()
        subVC.dismiss(animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
        
    }

    @IBAction func gotoSub(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

        self.dismiss(animated: true, completion: nil)
    }
    
    // Modally -> full screen
    /*
    @IBAction func gotoView(_ sender: UIButton) {
        let subVC = SubViewController()
        //let navigationController = UINavigationController(rootViewController: subVC)
        subVC.modalPresentationStyle = .fullScreen
        //show(subVC, sender: self)
        present(subVC, animated: true)
        //present(navigationController, animated: true)
    }*/
    
}

