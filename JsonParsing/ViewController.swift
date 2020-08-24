//
//  ViewController.swift
//  JsonParsing
//
//  Created by Munseok Park on 2020/08/21.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var titles:[String]=[]
    var images:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "영화목록"
        
        //주소 만들기
        let url = URL(string: "http://cyberadam.cafe24.com/movie/list")
        
        //다운로드 받기
        let data = try! Data(contentsOf: url!)
        //다운로드 받은 데이터를 NSDictionary로 만들기
        let jsonResult = try! JSONSerialization.jsonObject(with:data, options:[]) as! NSDictionary
        //channel 키의 값을 디셔너리로 가져오기
        let ar = jsonResult["list"] as! NSArray
        
        //반복문을 이용해서 배열의 데이터를 꺼낸 후 titles에 추가
        for index in 0...(ar.count-1){
            let item = ar[index] as! NSDictionary
            titles.append(item["title"] as! String)
            images.append(item["thumnailImage"] as! String)
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titles.count
    }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:UITableViewCell = UITableViewCell(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier:"cell")
            cell.textLabel?.text = titles[indexPath.row]
            let addr = images[indexPath.row]
            let imageUrl = URL(string: "http://cyberadam.cafe24.com/movieimage/\(addr)")
            let imageData = try! Data(contentsOf:imageUrl!)
            let image = UIImage(data: imageData)
            cell.imageView?.image = image
            return cell
    }

}


