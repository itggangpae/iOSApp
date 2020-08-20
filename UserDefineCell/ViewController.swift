//
//  ViewController.swift
//  UserDefineCell
//
//  Created by Munseok Park on 2020/08/17.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ar:Array<Dictionary<String, String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        
        let dic1 = ["name":"제시카", "skill":"영어", "imageName":"image1.png"]
        let dic2 = ["name":"유리", "skill":"중국어", "imageName":"image2.png"]
        let dic3 = ["name":"태연", "skill":"중국어", "imageName":"image3.png"]
        let dic4 = ["name":"윤아", "skill":"댄스", "imageName":"image4.png"]
        let dic5 = ["name":"티파니", "skill":"영어, 플롯", "imageName":"image5.png"]
        let dic6 = ["name":"수영", "skill":"일본어", "imageName":"image6.png"]
        
        ar = [dic1, dic2, dic3, dic4, dic5, dic6]
        
    }
    
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ar.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustomCell"
        var cell : CustomCell?
        cell = tableView.dequeueReusableCell(withIdentifier:cellIdentifier) as? CustomCell
        
        var dic = ar[indexPath.row]
        print(dic)
        
        cell!.lblName!.text = dic["name"]
        cell!.lblSkill!.text = dic["skill"]
        cell!.imgView!.image = UIImage(named:dic["imageName"]!)
        return cell!;
    }
}
