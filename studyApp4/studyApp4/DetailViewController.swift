//
//  DetailViewController.swift
//  studyApp4
//
//  Created by 문종식 on 2020/01/06.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var receiveItem = ""
    var receiveContent = ""
    var receiveIndex = 0
    var viewStatus = true // true - edit, false = save
    
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var textViewContent: UITextView!
    @IBOutlet var stBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
        textViewContent.text = receiveContent
        textViewContent.isEditable = false
    }
    
    func receiveItem(_ item:String){
        receiveItem = item
    }
    
    func receiveContent(_ content:String){
        receiveContent = content
    }
    
    func receiveIndex(_ index: Int){
        receiveIndex = index
    }


    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if viewStatus {
            textViewContent.isEditable = true
            textViewContent.layer.borderWidth = 1.0
            textViewContent.layer.cornerRadius = 5;
            textViewContent.layer.borderColor = UIColor.lightGray.cgColor
            stBtn.title = "Save"
            viewStatus = false
        } else {
            let textAlert = UIAlertController(title: "저장하시겠습니까?",
                                                message: "",
                                                preferredStyle: UIAlertController.Style.actionSheet)
            let saveAction = UIAlertAction(title: "Yes",
                                         style: UIAlertAction.Style.default,
                                         handler: {
                                            Action in
                                            itemsContents[self.receiveIndex] = self.textViewContent.text
            })
            let cancelAction = UIAlertAction(title: "No",
                                             style: UIAlertAction.Style.destructive,
                                             handler: {
                                                Action in self.textViewContent.text = self.receiveContent
            })
            textAlert.addAction(saveAction)
            textAlert.addAction(cancelAction)
            
            present(textAlert, animated: true, completion: nil)
            
            textViewContent.isEditable = false
            textViewContent.layer.borderWidth = 0
            stBtn.title = "Edit"
            viewStatus = true
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

}
