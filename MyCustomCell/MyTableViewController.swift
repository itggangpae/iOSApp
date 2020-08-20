//
//  MyTableViewController.swift
//  MyCustomCell
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

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
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell         {
        let cellIdentifier = "CustomCell"
        var cell : CustomCell?
        cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) as? CustomCell
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        cell!.imgView!.image = UIImage(named:delegate.image1[indexPath.row])
        return cell!;
    }

}
