//
//  ViewController.swift
//  DataUpdate
//
//  Created by Munseok Park on 2020/08/25.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import Alamofire
import Nuke
import WebKit

class ViewController: UIViewController {
    var imageView : UIImageView!
    
    var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let frame = UIScreen.main.bounds
         imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
         imageView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
         self.view.addSubview(imageView)
         */
        
        /*
         //이미지 파일의 내용을 다운로드 받기
         let addr = "http://192.168.1.95:9001/ios/images/car.jpg"
         let imageUrl = URL(string: addr)
         let imageData = try! Data(contentsOf: imageUrl!)
         let image = UIImage(data: imageData)
         imageView.image = image
         */
        
        /*
         let fm = FileManager.default
         //도큐먼트 디렉토리 경로를 생성
         let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
         let docDir = dirPaths[0]
         //파일 경로를 생성
         let filePath = docDir + "/car.jpg"
         */
        
        /*
         //파일이 없다면
         if fm.fileExists(atPath: filePath) == false{
         
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         let request = AF.request("http://192.168.1.95:9001/ios/images/car.jpg", method:.get, parameters:nil)
         request.response{
         response in
         // 인자값으로 받은 인덱스를 기반으로 해당하는 배열에서 데이터를 읽어옴
         let url: URL! = URL(string: "http://192.168.1.95:9001/ios/images/car.jpg")
         let options = ImageLoadingOptions(
         placeholder: UIImage(named: "dark-moon"),
         transition: .fadeIn(duration: 0.5)
         )
         Nuke.loadImage(with: url, options: options, into: self.imageView,
         progress:{ _, completed, total in
         print("다운로드 중")
         })
         //다운로드 받은 데이터로 파일을 생성
         fm.createFile(atPath: filePath, contents: response.data!, attributes: nil)
         UIApplication.shared.isNetworkActivityIndicatorVisible = false
         }
         }
         else{
         NSLog("존재하는 파일로 출력")
         let dataBuffer = fm.contents(atPath: filePath)
         //이미지 데이터로 변환
         let image = UIImage(data: dataBuffer!)
         //화면에 출력
         imageView.image = image
         }
         */
        
        /*
         let url = "http://192.168.1.95:9001/ios/updatetime"
         let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
         request.responseJSON{
         response in
         if response.error != nil{
         NSLog("서버에 접속할 수 없음")
         let image = UIImage(named: "red.jpg")
         self.imageView.image = image
         return
         }
         let updatePath = docDir + "/update.txt"
         var updatetime:String=""
         if fm.fileExists(atPath: updatePath){
         NSLog("업데이트 시간이 존재")
         let databuffer = fm.contents(atPath:updatePath)
         let log = NSString(data: databuffer!, encoding: String.Encoding.utf8.rawValue)
         let localupdatetime = log! as String
         if let jsonObject = response.value as? [String : Any]{
         updatetime = jsonObject["result"] as! String
         if updatetime == localupdatetime{
         NSLog("존재하는 파일로 출력")
         let dataBuffer = fm.contents(atPath: filePath)
         //이미지 데이터로 변환
         let image = UIImage(data: dataBuffer!)
         //화면에 출력
         self.imageView.image = image
         return
         }
         else{
         try! fm.removeItem(atPath: updatePath)
         let request = AF.request("http://192.168.1.95:9001/ios/images/car.jpg", method:.get, parameters:nil)
         request.response{
         response in
         let image = UIImage(data: response.data!)
         self.imageView!.image = image
         //다운로드 받은 데이터로 파일을 생성
         if fm.fileExists(atPath: filePath){
         try! fm.removeItem(atPath: filePath)
         }
         fm.createFile(atPath: filePath, contents: response.data!, attributes: nil)
         }
         }
         }
         }
         
         fm.createFile(atPath: updatePath, contents: updatetime.data(using: .utf8), attributes: nil)
         let request = AF.request("http://192.168.1.95:9001/ios/images/car.jpg", method:.get, parameters:nil)
         request.response{
         response in
         let image = UIImage(data: response.data!)
         self.imageView!.image = image
         //다운로드 받은 데이터로 파일을 생성
         if fm.fileExists(atPath: filePath){
         try! fm.removeItem(atPath: filePath)
         }
         fm.createFile(atPath: filePath, contents: response.data!, attributes: nil)
         }
         }
         */
        
        /*
         let frame = UIScreen.main.bounds
         webView = WKWebView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
         self.view.addSubview(webView)
         
         let pdfPath = Bundle.main.path(forResource: "Bluetooth", ofType: "pdf")
         let pdfURL = URL(fileURLWithPath: pdfPath!)
         let pdfRequest = URLRequest(url: pdfURL)
         webView.load(pdfRequest)
         */
        
        /*
         let frame = UIScreen.main.bounds
         webView = WKWebView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
         self.view.addSubview(webView)
         
         let htmlPath = Bundle.main.path(forResource: "test", ofType: "html")
         let htmlURL = URL(fileURLWithPath: htmlPath!)
         let htmlString = try! String(contentsOf: htmlURL)
         
         webView.loadHTMLString(htmlString, baseURL: nil)
         */
        
        /*
        let parameterS: Parameters = ["itemname": "과자", "description":"맛있다", "price":"1500"]
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                }
                let image = UIImage(named: "red.jpg")
                multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "pictureurl" , fileName: "file.jpeg", mimeType: "image/jpeg")
        },to: "http://cyberadam.cafe24.com/item/insert", method: .post , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                NSLog(String(data:response.data!, encoding: .utf8)!)
        }
 */
        
        let parameterS: Parameters = ["email": "ggangpae2@gmail.com", "nickname":"군계2", "pw":"1234"]
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                }
                let image = UIImage(named: "red.jpg")
                multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "profile" , fileName: "file.jpeg", mimeType: "image/jpeg")
        },to: "http://cyberadam.cafe24.com/member/join", method: .post , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                NSLog(String(data:response.data!, encoding: .utf8)!)
        }
    }
}

