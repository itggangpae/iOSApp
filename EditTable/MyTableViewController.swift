//
//  MyTableViewController.swift
//  EditTable
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    var data:Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = ["iPod", "iPhone", "iPad"]
        
        self.navigationItem.title = "테이블 뷰 업데이트"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertItem(_:)))
        self.navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //return .delete
        return .none
    }
    
    //editButton 버튼을 누른 후 삭제 버튼을 누르거나 셀에서 오른쪽에서 왼쪽으로 스와이프 했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        data?.remove(at: indexPath.row)
        //tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data!.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if (cell == nil)
        {
            cell = UITableViewCell(style:.default, reuseIdentifier:cellIdentifier)
        }
        cell?.textLabel?.text = data![indexPath.row]
        return cell!
        
    }
    
    @objc func insertItem(_ sender:UIBarButtonItem){
        let alert = UIAlertController(title: "아이템 등록",
                                      message: "신규 아이템 이름을 입력하세요",
                                      preferredStyle: .alert)
        // 부서명 및 주소 입력용 텍스트 필드 추가
        alert.addTextField() { (tf) in tf.placeholder = "아이템 이름" }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in
            let item = alert.textFields?[0].text
            if item == nil || item!.trimmingCharacters(in: .whitespaces).count == 0{
                return
            }
            self.data?.append(item!)
            //self.tableView.reloadData()
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.data!.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
            
        })
        self.present(alert, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            let movedObject = data?[sourceIndexPath.row]
            data?.remove(at: sourceIndexPath.row)
            data?.insert(movedObject!, at: destinationIndexPath.row)
    }
     
}
