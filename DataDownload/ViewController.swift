//
//  ViewController.swift
//  DataDownload
//
//  Created by Munseok Park on 2020/08/21.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imgView : UIImageView!
    var tv:UITextView!
    var fileMgr:FileManager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
               tv = UITextView(frame:CGRect(x:0,y:220,width:320,height:350))
                let naver = URL(string:"https://www.naver.com")
                let naverdata = try! Data(contentsOf:naver!)
                   let naverstring = String.init(data: naverdata, encoding: .utf8)
                tv!.text = naverstring
                tv!.isEditable = false
                view.addSubview(tv!)
        
        imgView = UIImageView(frame: CGRect(x:0,y:0,width:320,height:200))
                
        //이미지 파일의 내용을 다운로드 받기
        let addr = "http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG"
        let imageUrl = URL(string: addr)
        let imageData = try! Data(contentsOf: imageUrl!)
        
        //이미지 데이터로 변환
        let image = UIImage(data: imageData)
        
        //화면에 출력
        imgView.image = image
        view.addSubview(imgView!)

    }


}

