//
//  ViewController.swift
//  GestureTest
//
//  Created by Munseok Park on 2020/08/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imgView : UIImageView!
    var oldScale : CGFloat = 1.0
    
    //회전이 발생하기 전의 각도를 저장할 프로퍼티
    var originalRotation: CGFloat = 0
    //회전이 발생하는 도중의 각도를 저장할 프로퍼티
    var lastRotation: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //image1.png 파일을 가지고 UIImageView 객체 생성
        imgView = UIImageView.init(frame: CGRect(x:50, y:50, width:200, height:200))
        imgView.center = self.view.center;
        //이미지는 생성한 디렉토리와 상관없이 이름을 기재하면 됩니다.
        imgView.image = UIImage.init(named: "red0.jpg")
        imgView.contentMode = UIView.ContentMode.scaleAspectFit;
        imgView.isUserInteractionEnabled = true
        self.view.addSubview(imgView)
        
        //탭이 발생하면 self에 있는 tapGestureMethod:를 호출하는
        //UITapGestureRecognizer 객체를 생성
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureMethod))
        //필요한 탭의 수는 2라고 지정
        tap.numberOfTapsRequired = 2;
        //imgView에 생성한 객체를 추가
        imgView.addGestureRecognizer(tap)
        
        let pinch = UIPinchGestureRecognizer.init(target: self, action: #selector(pinchGestureMethod))
        //imgView에 생성한 객체를 추가
        imgView.addGestureRecognizer(pinch)

        let rotate = UIRotationGestureRecognizer(target: self, action:     #selector(rotatedView(_:)))
        imgView.addGestureRecognizer(rotate)

        // Do any additional setup after loading the view.
    }
    //탭 제스쳐 객체가 호출하는 메소드
    @objc func tapGestureMethod(sender:UITapGestureRecognizer)
    {
        //imgView의 모드가 UIViewContentModeScaleAspectFit 이면 Center로 변경
        if sender.view!.contentMode == UIView.ContentMode.scaleAspectFit
        {
            sender.view!.contentMode = UIView.ContentMode.center;
        }
            //Center모드이면 UIViewContentModeScaleAspectFit로 변경
        else{
            sender.view!.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
    //핀치 제스쳐 객체가 호출하는 메소드
    @objc func pinchGestureMethod(sender:UIPinchGestureRecognizer){
    let  newScale = sender.scale
    if (newScale > 1)
    {
        imgView.transform = CGAffineTransform(scaleX:oldScale + (newScale-1), y:oldScale + (newScale-1))
        
    }else
    {
        imgView.transform = CGAffineTransform(scaleX:oldScale * newScale, y:oldScale * newScale)
    }
    //핀치 제스쳐가 종료되면(터치 이벤트가 없다면)새로 적용된 배율을 oldScale에 저장
    if sender.state == UIGestureRecognizer.State.ended
    {
        if (newScale > 1)
        {
            oldScale += (newScale-1)
        }
        else
        {
            oldScale *= newScale}
        }
    }
    
    @objc func rotatedView(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .began {
            sender.rotation = lastRotation
            originalRotation = sender.rotation
        } else if sender.state == .changed {
            let newRotation = sender.rotation + originalRotation
            sender.view?.transform = CGAffineTransform(rotationAngle: newRotation)
        } else if sender.state == .ended {
            // Save the last rotation
            lastRotation = sender.rotation
        }
    }

}

