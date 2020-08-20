//
//  ViewController.swift
//  Clock
//
//  Created by Munseok Park on 2020/08/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var timer:Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //현재 클래스에 만들어져 있는 timerProc 라는 메소드를
        //1초마다 무한 반복해서 호출하는 타이머를 생성
        /*
         //selector를 이용하는 방법
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerProc), userInfo: nil, repeats: true)
        */
        
        //closure를 이용하는 방법
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){(timer:Timer) -> Void in let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd ccc hh:mm:ss"
        let msg = formatter.string(from:date)
            self.label.text = String(msg)}
        
        //180도 회전
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        //경계선 설정
        label.layer.borderWidth = 3.0
        label.layer.borderColor = UIColor.red.cgColor

    }

    @objc func timerProc() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd ccc hh:mm:ss"
        let msg = formatter.string(from:date)
        label.text = String(msg)
    }
    

}

