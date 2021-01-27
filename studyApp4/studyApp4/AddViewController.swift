//
//  AddViewController.swift
//  studyApp4
//
//  Created by 문종식 on 2020/01/06.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {

    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var selectPickerView: UIPickerView!
    @IBOutlet var textView: UITextView!
    
    var imageFiles = ["cart.png", "clock.png", "pencil.png"]
    var category = ["Shopping", "Schedule", "Study"]
    let MAX_ARRAY_NUM = 3
    let PICKER_VIEW_COLUMN = 1
    var PICKER_VIEW_HEIGHT:CGFloat = 90
    var imageArray = [UIImage?]()
    var selectItem = ""
    
    @IBOutlet var lblCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFiles[i])
            imageArray.append(image)
        }
        // Do any additional setup after loading the view.
        lblCategory.text = category[0]
        selectItem = imageFiles[0]
        
        self.textView.delegate = self
        self.textView.layer.borderWidth = 1.0
        self.textView.layer.cornerRadius = 5;
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return imageFiles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectItem = imageFiles[row]
        lblCategory.text = category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        
        return imageView
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        itemsImageFile.append(selectItem)
        itemsContents.append(textView.text!)
        tfAddItem.text = ""
        _ = navigationController?.popViewController(animated: true) // Root View(Table View)로 돌아감
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
