//
//  ViewController.swift
//  TouchEventApp
//
//  Created by Munseok Park on 2020/08/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification,
                                               object: nil,
                                               queue: .main,
                                               using: didRotate)
        self.becomeFirstResponder()
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 2.0;
        longPress.allowableMovement = 15;
        self.view.addGestureRecognizer(longPress)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        let tapCount = touch!.tapCount
        
        label1.text = "터치 시작";
        label2.text = "\(tapCount) 번 탭"
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        label1.text = "터치 이동";
        let touch = touches.first
        if touch!.view == imgView{
            imgView.center = touch!.location(in:self.view)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,  with event: UIEvent?) {
        label1.text = "터치 종료"
    }
    
    //뷰 컨트롤러가 돌아가는 것을 결정하는 Bool 타입의 뷰 컨트롤러 인스턴스 프로퍼티
    override var shouldAutorotate: Bool {
        return true // or false
    }
    
    //특정 방향 지원여부를 설정하는 메소드
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.all]
    }
    //뷰의 크기가 변경될 때 호출되는 메소드
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            NSLog("가로로 회전")
        } else {
            NSLog("세로로 회전")
        }
    }
    
    var didRotate: (Notification) -> Void = { notification in
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            NSLog("Noti - landscape")
        case .portrait, .portraitUpsideDown:
            NSLog("Noti - Portrait")
        default:
            print("other")
        }
    }
    
    override var canBecomeFirstResponder: Bool{
            get{
                return true
            }
    }

    override func motionBegan(_ motion:UIEvent.EventSubtype, with event: UIEvent?){
            let alert = UIAlertController(title: "모션 테스트", message: "흔들기 시작", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated:true)
    }
        
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                NSLog("Why are you shaking me?")
            }
    }

    @objc func menuEvent(){
            let alert = UIAlertController(title: "메뉴 테스트", message: "메뉴 선택", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated:true)
    }

    @objc func handleLongPress(sender : UILongPressGestureRecognizer)
        {
            self.becomeFirstResponder()
            
            let menuItem = UIMenuItem(title:"Menu", action:#selector(menuEvent))
            UIMenuController.shared.menuItems = [menuItem]
            let pt = sender.location(in:self.view)
             if #available(iOS 13.0, *) {
                NSLog("13 이상");
                UIMenuController.shared.showMenu(from: self.view, rect: CGRect(x:pt.x-50,y:pt.y+15,width:100,height:100))
                
    
             } else {
                NSLog("13 미만");
                     UIMenuController.shared.setTargetRect(CGRect(x:pt.x-50,y:pt.y+15,width:100,height:100),in:self.view)
                     UIMenuController.shared.setMenuVisible(true, animated:true)
    
            }
        }
}

