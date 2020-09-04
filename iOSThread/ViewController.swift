//
//  ViewController.swift
//  iOSThread
//
//  Created by Munseok Park on 2020/08/21.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

/*
 class ImageDownloader : Thread {
 var imageView : UIImageView!
 var url : URL!
 override func main() {
 let imageData = try! Data(contentsOf: url)
 let image = UIImage(data: imageData)
 imageView.image = image
 }
 }
 */

/*
 class ImageDownloader : Thread {
 var imageView : UIImageView!
 var url : URL!
 override func main() {
 let queue = OperationQueue()
 queue.addOperation {
 let imageData = try! Data(contentsOf: self.url)
 let image = UIImage(data: imageData)
 OperationQueue.main.addOperation {
 self.imageView.image = image
 }
 }
 }
 }
 */

class ImageDownloader : Thread {
    var imageView : UIImageView!
    var url : URL!
    override func main() {
        self.performSelector(onMainThread: #selector(download), with: nil, waitUntilDone: false)
    }
    
    @objc func download(){
        let imageData = try! Data(contentsOf: self.url)
        let image = UIImage(data: imageData)
        self.imageView.image = image
    }
}

class ViewController: UIViewController {
    var imageView : UIImageView!
    var imageName : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //화면 전체 크기 가져오기
        let frame = UIScreen.main.bounds
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.view.addSubview(imageView)
        
        let addr = "http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG"
        let imageUrl = URL(string: addr)
        
        /*
         let downloader = ImageDownloader()
         downloader.imageView = imageView
         downloader.url = imageUrl
         
         downloader.start()
         */
        
        let session = URLSession.shared
        let task = session.dataTask(with: imageUrl!,
                                    completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
                                        if error != nil{
                                            NSLog("다운로드 에러:\(error!.localizedDescription)")
                                            return
                                        }
                                        // 메인 쓰레드에서 이미지를 이미지 뷰에 반영
                                        OperationQueue.main.addOperation { self.imageView.image = UIImage(data: data!)
                                        }
        })
        task.resume()
        
        imageName = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        imageName.center = CGPoint(x: imageView.center.x, y:imageView.center.y + 200)
        imageName.textAlignment = .center
        imageName.text = "수지"
        self.view.addSubview(imageName)
        
        
        
        // Prepare URL
        let url = URL(string: "http://cyberadam.cafe24.com/member/login")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "email=ggangpae1@gmail.com&pw=1234";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task1 = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task1.resume()
    }
}

