//
//  ViewController.swift
//  AlamofireMovie
//
//  Created by Munseok Park on 2020/08/24.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var imgView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let request = AF.request("https://httpbin.org/get", method:.get, parameters:nil)
         request.response{
         response in
         let msg = String.init(data: response.data!, encoding: String.Encoding.utf8)
         print(msg!)
         }
         */
        
        /*
         let request = AF.request("https://www.daum.net", method:.get, parameters:nil)
         request.responseString(completionHandler: {response -> Void in
         print(response.value!)
         }
         )
         */
        
        /*
         self.imgView = UIImageView(frame: CGRect(x:0,y:0,width:320,height:200))
         self.view.addSubview(self.imgView!)
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         let request = AF.request("http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG", method:.get, parameters:nil)
         request.response{
         response in
         
         print(response.data!)
         let image = UIImage(data: response.data!)
         //화면에 출력
         sleep(10)
         self.imgView!.image = image
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         }
         */
        
        let addr = "https://dapi.kakao.com/v3/search/book?target=title&query="
        let query = "자바".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "\(addr)\(query!)"
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "KakaoAK 06fab290c9f4eb6f130c09796d57bc30"])
        
        request.responseJSON{
            response in
            //print(response.result.value!)
            if let jsonObject = response.value as? [String : Any]{
                let documents = jsonObject["documents"] as! NSArray
                for index in 0...(documents.count-1){
                    let item = documents[index] as! NSDictionary
                    print("\(item["authors"]!) - \(item["title"]!)")
                }
            }
        }
        
        
    }
}

