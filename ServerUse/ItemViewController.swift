//
//  ItemViewController.swift
//  ServerUse
//
//  Created by Munseok Park on 2020/09/01.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import Alamofire
import Nuke


//데이터 저장을 위한 구조체
struct Item{
    var itemid : Int?
    var itemname : String?
    var price : Int?
    var description : String?
    var pictureurl : String?
    var updatedate : String?
}

class ItemViewController: UITableViewController {
    var itemList = Array<Item>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "과일"
        // 앱 내 문서 디렉터리 경로에서 SQLite DB 파일을 찾는다.
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dbPath = docPathURL.appendingPathComponent("item.sqlite").path
        let updatePath = docPathURL.appendingPathComponent("update.txt").path
        //다운로드 받을 URL 만들기
        let url = "http://cyberadam.cafe24.com/item/list"
        
        //데이터 파일이 없다면 데이터 가져오기
        if fileMgr.fileExists(atPath: dbPath) == false {
            let alert = UIAlertController(title: "데이터 가져오기",
                                          message: "데이터가 없으므로 서버에서 가져와야 합니다.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
            
            
            //로컬 데이터베이스 만들기
            let itemDB = FMDatabase(path: dbPath)
            itemDB.open()
            
            //데이터 가져오기
            //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
            let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
            request.responseJSON{
                response in
                //print(response.result.value!)
                if let jsonObject = response.value as? [String : Any]{
                    let list = jsonObject["list"] as! NSArray
                    
                    let sql_stmt = "CREATE TABLE IF NOT EXISTS item (itemid INTEGER NOT NULL PRIMARY KEY, itemname TEXT, price INTEGER, description TEXT, pictureurl TEXT, updatedate TEXT)"
                    itemDB.executeStatements(sql_stmt)
                    
                    for index in 0...(list.count-1){
                        let itemDict = list[index] as! NSDictionary
                        var item = Item()
                        // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                        item.itemid = ((itemDict["itemid"] as! NSNumber).intValue)
                        item.itemname = itemDict["itemname"] as? String
                        item.price = ((itemDict["price"] as! NSNumber).intValue)
                        item.description = itemDict["description"] as? String
                        item.pictureurl = itemDict["pictureurl"] as? String
                        item.updatedate = itemDict["updatedate"] as? String
                        self.itemList.append(item)
                        
                        let sql = """
                          INSERT INTO item (itemid, itemname, price, description, pictureurl, updatedate)
                          VALUES (:itemid, :itemname, :price, :description, :pictureurl)
                        """
                        
                        var paramDictionary = [String:Any]()
                        paramDictionary["itemid"] = item.itemid!
                        paramDictionary["itemname"] = item.itemname!
                        paramDictionary["price"] = item.price!
                        paramDictionary["description"] = item.description!
                        paramDictionary["pictureurl"] = item.pictureurl!
                        //paramDictionary["updatedate"] = item.updatedate!
                        itemDB.executeUpdate(sql, withParameterDictionary: paramDictionary)
                    }
                    NSLog("데이터 저장 성공")
                }
                self.tableView.reloadData()
                itemDB.close()
                
                //업데이트 한 시간 저장하기
                let updateurl = "http://cyberadam.cafe24.com/item/date"
                //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
                let updaterequest = AF.request(updateurl, method: .get, encoding: JSONEncoding.default, headers:[:])
                updaterequest.responseJSON{
                    response in
                    //print(response.result.value!)
                    if let jsonObject = response.value as? [String : Any]{
                        let result = jsonObject["result"] as? String
                        let databuffer = result!.data(using: String.Encoding.utf8)
                        //텍스트 파일에 기록
                        fileMgr.createFile(atPath: updatePath, contents: databuffer, attributes: nil)
                    }
                }
                
            }
        }
        else{
            let databuffer = fileMgr.contents(atPath: updatePath)
            let updatetime = NSString(data: databuffer!, encoding: String.Encoding.utf8.rawValue) as String?
            //업데이트 한 시간 저장하기
            let updateurl = "http://cyberadam.cafe24.com/item/date"
            //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
            let updaterequest = AF.request(updateurl, method: .get, encoding: JSONEncoding.default, headers:[:])
            updaterequest.responseJSON{
                response in
                //print(response.result.value!)
                if let jsonObject = response.value as? [String : Any]{
                    let result = jsonObject["result"] as? String
                    if updatetime  == result{
                        let alert = UIAlertController(title: "데이터 가져오기",
                                                      message: "서버의 데이터와 기존 데이터가 변화가 없으므로 기존 데이터를 출력합니다..",
                                                      preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alert, animated: false)
                        
                        //로컬 데이터베이스 만들기
                        let itemDB = FMDatabase(path: dbPath)
                        itemDB.open()
                        do {
                            // 1.전화번호부 목록을 가져올 SQL 작성 및 쿼리 실행
                            let sql = """
                          SELECT *
                          FROM item
                          ORDER BY itemid ASC
                        """
                            let rs = try itemDB.executeQuery(sql, values: nil)
                            self.itemList.removeAll()
                            // 2. 결과 집합 추출
                            while rs.next() {
                                var item = Item()
                                
                                item.itemid = Int(rs.int(forColumn: "itemid"))
                                item.itemname = rs.string(forColumn: "itemname")
                                item.price = Int(rs.int(forColumn: "price"))
                                item.description = rs.string(forColumn: "description")
                                item.pictureurl = rs.string(forColumn: "pictureurl")
                                item.updatedate = rs.string(forColumn: "updatedate")
                                // append 메소드 호출 시 아래 튜플을 괄호 없이 사용하지 않도록 주의
                                self.itemList.append(item)
                            }
                            self.tableView.reloadData()
                            
                        } catch let error as NSError {
                            NSLog("failed: \(error.localizedDescription)")
                        }
                        
                        itemDB.close()
                    }else{
                        
                        let alert = UIAlertController(title: "데이터 가져오기",
                                                      message: "서버의 데이터와 기존 데이터가 다르므로 데이터를 다시 가져옵니다.",
                                                      preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alert, animated: false)
                        
                        try! fileMgr.removeItem(atPath:dbPath)
                        try! fileMgr.removeItem(atPath:updatePath)
                        
                        //로컬 데이터베이스 만들기
                        let itemDB = FMDatabase(path: dbPath)
                        itemDB.open()
                        
                        //데이터 가져오기
                        //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
                        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
                        request.responseJSON{
                            response in
                            //print(response.result.value!)
                            if let jsonObject = response.value as? [String : Any]{
                                let list = jsonObject["list"] as! NSArray
                                
                                let sql_stmt = "CREATE TABLE IF NOT EXISTS item (itemid INTEGER NOT NULL PRIMARY KEY, itemname TEXT, price INTEGER, description TEXT, pictureurl TEXT, updatedate TEXT)"
                                itemDB.executeStatements(sql_stmt)
                                
                                for index in 0...(list.count-1){
                                    let itemDict = list[index] as! NSDictionary
                                    var item = Item()
                                    // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                                    item.itemid = ((itemDict["itemid"] as! NSNumber).intValue)
                                    item.itemname = itemDict["itemname"] as? String
                                    item.price = ((itemDict["price"] as! NSNumber).intValue)
                                    item.description = itemDict["description"] as? String
                                    item.pictureurl = itemDict["pictureurl"] as? String
                                    item.updatedate = itemDict["updatedate"] as? String
                                    self.itemList.append(item)
                                    
                                    let sql = """
                                       INSERT INTO item (itemid, itemname, price, description, pictureurl, updatedate)
                                       VALUES (:itemid, :itemname, :price, :description, :pictureurl, :updatedate)
                                     """
                                    
                                    var paramDictionary = [String:Any]()
                                    paramDictionary["itemid"] = item.itemid!
                                    paramDictionary["itemname"] = item.itemname!
                                    paramDictionary["price"] = item.price!
                                    paramDictionary["description"] = item.description!
                                    paramDictionary["pictureurl"] = item.pictureurl!
                                    paramDictionary["updatedate"] = item.updatedate!
                                    itemDB.executeUpdate(sql, withParameterDictionary: paramDictionary)
                                }
                                NSLog("데이터 저장 성공")
                            }
                            self.tableView.reloadData()
                            itemDB.close()
                            
                            //업데이트 한 시간 저장하기
                            let updateurl = "http://cyberadam.cafe24.com/item/date"
                            //데이터를 다운로드 받아서 파싱해서 itemList에 저장하기
                            let updaterequest = AF.request(updateurl, method: .get, encoding: JSONEncoding.default, headers:[:])
                            updaterequest.responseJSON{
                                response in
                                //print(response.result.value!)
                                if let jsonObject = response.value as? [String : Any]{
                                    let result = jsonObject["result"] as? String
                                    let databuffer = result!.data(using: String.Encoding.utf8)
                                    //텍스트 파일에 기록
                                    fileMgr.createFile(atPath: updatePath, contents: databuffer, attributes: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let loginPath = docPathURL.appendingPathComponent("login.txt").path
        let buttonTitle : String!
        
        if !fileMgr.fileExists(atPath: loginPath){
            buttonTitle = "로그인"
        }else{
            let databuffer = fileMgr.contents(atPath: loginPath)
            let logintext = String(bytes: databuffer!, encoding: .utf8)
            let ar = logintext?.components(separatedBy: ":")
            self.title = ar![1]
            buttonTitle = "로그아웃"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(login(_:)))
    }
    
    @objc func login(_ sender: Any) {
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        let loginPath = docPathURL.appendingPathComponent("login.txt").path
        
        let barButtonItem = sender as! UIBarButtonItem
        if barButtonItem.title == "로그인"{
            
            let alert = UIAlertController(title: "로그인",
                                          message: "이메일과 비밀번호를 입력하세요",
                                          preferredStyle: .alert)
            
            alert.addTextField() { (tf) in tf.placeholder = "이메일을 입력하세요!" }
            alert.addTextField() { (tf) in tf.placeholder = "비밀번호를 입력하세요!"
                tf.isSecureTextEntry = true
            }
            alert.addAction(UIAlertAction(title: "취소", style: .cancel)) // 취소 버튼
            alert.addAction(UIAlertAction(title: "로그인", style: .default) {
                (_) in // 확인 버튼
                
                let email = alert.textFields?[0].text
                let pw = alert.textFields?[1].text
                
                let parameters = ["email" : email!, "pw":pw!]
                NSLog(parameters.description)
                let request = AF.request("http://cyberadam.cafe24.com/member/login", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
                request.responseJSON{
                    response in
                    if let jsonObject = response.value as? [String : Any]{
                        let result = jsonObject["login"] as! Int32
                        
                        var msg : String!
                        if result == 1{
                            msg = "로그인 성공"
                            barButtonItem.title = "로그아웃"
                            
                            let nickname = jsonObject["nickname"] as! String
                            let profile = jsonObject["profile"] as! String
                            
                            let data = "\(email!):\(nickname):\(profile)"
                            let databuffer = data.data(using: String.Encoding.utf8)
                            
                            //텍스트 파일에 기록
                            fileMgr.createFile(atPath: loginPath, contents: databuffer, attributes: nil)
                            self.title = nickname
                        }else{
                            msg = "로그인 실패:아이디나 비밀번호가 틀렸습니다."
                        }
                        
                        let alert = UIAlertController(title: "로그인",
                                                      message: msg,
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                        self.present(alert, animated: false)
                    }
                }
                
            })
            self.present(alert, animated: false)
            
        }else{
            try! fileMgr.removeItem(atPath: loginPath)
            let alert = UIAlertController(title: "로그인",
                                          message: "로그아웃 하셨습니다.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
            barButtonItem.title = "로그인"
            self.title = "과일"
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let item = self.itemList[indexPath.row]
        
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell!.textLabel!.text = item.itemname
        cell!.detailTextLabel!.text = item.description
        DispatchQueue.main.async(execute: {
            let url: URL! = URL(string: "http://cyberadam.cafe24.com/img/\(item.pictureurl!)")
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "placeholder"),
                transition: .fadeIn(duration: 2)
            )
            Nuke.loadImage(with: url, options: options, into: cell!.imageView!)
        })
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1.삭제할 행의 itemid를 구한다.
        let itemid = itemList[indexPath.row].itemid
        
        // 2. DB에서, 데이터 소스에서, 그리고 테이블 뷰에서 차례대로 삭제한다.
        self.itemList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        // 3. 서버에서 데이터 삭제
        let parameters = ["itemid" : "\(itemid!)"]
        NSLog(parameters.description)
        
        let request = AF.request("http://cyberadam.cafe24.com/item/delete", method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil)
        request.responseJSON{
            response in
            //print(response.result.value!)
            if let jsonObject = response.value as? [String : Any]{
                let result = jsonObject["result"] as! Int32
                
                var msg : String!
                if result == 1{
                    msg = "성공"
                }else{
                    msg = "실패:\(jsonObject["error"] as! String)"
                }
                
                let alert = UIAlertController(title: "데이터 삭제",
                                              message: msg,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                self.present(alert, animated: false)
            }
        }
    }
}
