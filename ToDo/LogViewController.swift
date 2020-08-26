//
//  LogViewController.swift
//  ToDo
//
//  Created by Munseok Park on 2020/08/26.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
public enum LogType: Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}

extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0 : return "생성"
        case 1 : return "수정"
        case 2 : return "삭제"
        default: return ""
        }
    }
}

class LogViewController: UITableViewController {
    var toDo:ToDoMO!
        
    lazy var list : [LogMO]! = {
            return self.toDo.logs?.allObjects as! [LogMO]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.list.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let row = self.list[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
            cell.textLabel?.text = "\(row.regdate!)에 \(row.type.toLogType())되었습니다"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            
            return cell
    }


}
