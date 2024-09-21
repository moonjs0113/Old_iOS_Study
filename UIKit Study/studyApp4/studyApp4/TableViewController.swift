//
//  TableViewController.swift
//  studyApp4
//
//  Created by 문종식 on 2020/01/06.
//  Copyright © 2020 문종식. All rights reserved.
//

import UIKit

var items = ["책 구매", "철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]
var itemsContents = ["스위프트로 아이폰 앱 만들기","오후 2시 학교 앞","Swift 5.0"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // 상단 "edit" 버튼으로 목록 삭제하기
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // 뷰가 로드되었을 때 호출되는 함수 순서
    // viewDidLoad -> viewWillAppear -> viewDidAppear
    // But, 뷰가 전화되어 올 때는 viewWillAppear -> viewDidAppear 만 작동함
    // viewDidLoad: 뷰로 로드되었을 때 호출됨. 뷰가 생성될 떄 한 번만 호출됨.
    // viewWillAppear: 뷰가 노출될 준비가 끝났을 때 호출되는 함수. 뷰가 노출될 때마다 호출됨
    // viewDidAppear: 뷰가 완전히 로드된(보인) 후 호출되는 함수.
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation,
        
        return 1 // return the number of sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation,
        return items.count // return the number of rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TableViewController -> Prototype Cells의 identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        // 전역 변수로 선언한 셀 레이블 적용 코드
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // 목록 삭제 코드
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            itemsContents.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    
    // Override to support rearranging the table view.
    // 목록 바꾸기 코드
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 위치를 itemToMove에 저장
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 이미지를 itemImageToMove에 저장
        let itemContentToMove = itemsContents[(fromIndexPath as NSIndexPath).row]
        
        items.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템을 삭제 -> 나머지 아이템들의 인덱스가 재정렬됨
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템의 이미지를 삭제 -> 나머지 아이템들의 인덱스가 재정렬됨
        itemsContents.remove(at: (fromIndexPath as NSIndexPath).row)
        
        items.insert(itemToMove, at: (to as NSIndexPath).row) // 삭제된 아이템을 이동할 위치로 삽입 -> 나머지 아이템들의 인덱스가 재정렬됨
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row) // 삭제된 아이템의 이미지를 이동할 위치로 삽입 -> 나머지 아이템들의 인덱스가 재정렬됨
        itemsContents.insert(itemContentToMove, at: (fromIndexPath as NSIndexPath).row)
        
    
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)])
            detailView.receiveContent(itemsContents[((indexPath! as NSIndexPath).row)])
            detailView.receiveIndex( Int((indexPath! as NSIndexPath).row) )
        }
    }
    

}
