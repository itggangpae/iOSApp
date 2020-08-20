//
//  AttractionTableViewController.swift
//  NaviWeb
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class AttractionTableViewController: UITableViewController {
    var attractionImages = [String]()
    var attractionNames = [String]()
    var webAddresses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attractionNames = ["버킹검 궁전",
                           "에펠탑",
                           "엠파이어 빌딩"]
        webAddresses = ["http://en.wikipedia.org/wiki/Buckingham_Palace",
                        "http://en.wikipedia.org/wiki/Eiffel_Tower",
                        "http://en.wikipedia.org/wiki/Empire_State_Building"]
        attractionImages = ["buckingham_palace.jpg",
                            "eiffel_tower.jpg",
                            "empire_state_building.jpg"]
        self.title = "관광명소"
        
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action:#selector(handleRefresh(_:)),
            for:.valueChanged)
        refreshControl?.tintColor = UIColor.red
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        
        
    }
    
    //테이블의 섹션 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //세션별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attractionNames.count
        
    }
    
    //섹션별 행 별 셀을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AttractionTableCell")as! AttractionTableViewCell
        
        let row = indexPath.row
        cell.attractionLabel.font =
            UIFont.preferredFont(forTextStyle:.headline)
        cell.attractionLabel.text = attractionNames[row]
        cell.attractionImage.image = UIImage(named: attractionImages[row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    //행 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "AttractionDetailViewController") as! AttractionDetailViewController
        detailViewController.title = attractionNames[indexPath.row]
        detailViewController.webSite = webAddresses[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        attractionNames.insert("그랜드캐년", at: 0)
        attractionNames.insert("윈저궁", at: 0)
        
        webAddresses.insert("http://en.wikipedia.org/wiki/grand_canyon", at: 0)
        webAddresses.insert("http://en.wikipedia.org/wiki/windsor_castle", at: 0)
        
        attractionImages.insert("grand_canyon.jpg", at: 0)
        attractionImages.insert("windsor_castle.jpg", at: 0)
        sleep(5)
        refreshControl.endRefreshing()
        
        let ar = [IndexPath(row:0,section: 0), IndexPath(row:1,section: 0)]
        tableView.beginUpdates()
        tableView.insertRows(at:ar, with: .top)
        tableView.endUpdates()
        
    }
    
    var flag = false
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if (flag == false && indexPath.row == self.attractionNames.count - 1 ) {
            flag = true
            
        }else if(flag == true && indexPath.row == self.attractionNames.count - 1){
            attractionNames.append("그랜드캐년")
            attractionNames.append("윈저궁")
            
            webAddresses.append("http://en.wikipedia.org/wiki/grand_canyon")
            webAddresses.append("http://en.wikipedia.org/wiki/windsor_castle")
            
            attractionImages.append("grand_canyon.jpg")
            attractionImages.append("windsor_castle.jpg")
            
            tableView.reloadData()
        }
    }
    
}
