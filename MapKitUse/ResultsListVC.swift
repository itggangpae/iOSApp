//
//  ResultsListVC.swift
//  MapKitUse
//
//  Created by Munseok Park on 2020/09/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import MapKit

class ResultsListVC: UITableViewController {
    var mapItems: [MKMapItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        NSLog("1")
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         NSLog("2")
        return mapItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("3")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableCell", for: indexPath) as! ResultsTableCell
        
        let row = indexPath.row
        
        if let item = mapItems?[row] {
            cell.nameLabel.text = item.name
            cell.phoneLabel.text = item.phoneNumber
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat             {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let RouteVC = self.storyboard?.instantiateViewController(identifier: "RouteVC")
            as! RouteVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow,
            let destination = mapItems?[indexPath.row] {
            RouteVC.destination = destination
        }
        self.navigationController?.pushViewController(RouteVC, animated: true)
    }

}
