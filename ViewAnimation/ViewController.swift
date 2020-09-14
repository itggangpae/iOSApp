//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Munseok Park on 2020/09/15.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView: UIImageView!
    var flag = 1.0
    
    var scaleFactor: CGFloat = 2
    var angle: Double = 180
    var boxView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageView1.removeFromSuperview()
        
        let frameRect = CGRect(x: 20, y: 20, width: 45, height: 45)
        boxView = UIView(frame: frameRect)
        
        if let view = boxView {
            view.backgroundColor = UIColor.blue
            self.view.addSubview(view)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         if flag == 0{
         flag = 1
         }
         else{
         flag = 0
         }
         */
        
        /*
         UIView.animate(withDuration: 3, delay: 0.0, options: [.autoreverse], animations: {
         //적용되는 애니메이션은 알파 값 수정
         self.imageView.alpha = CGFloat(self.flag)
         self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(90 * Double.pi / 2))
         }, completion: nil)
         */
        
        /*
         UIView.animate(withDuration:1.0) {
         let newCenter = CGPoint(x: 200, y: 200)
         self.imageView.center = newCenter
         }
         */
        
        /*
         UIView.animate(withDuration:1.0, animations: { () -> Void in
         self.imageView.center = CGPoint(x: 200, y: 200)
         }) { (finished) -> Void in
         UIView.animate(withDuration: 1.0) {
         self.view.backgroundColor = UIColor.blue
         }
         }
         */
        
        /*
         UIView.animate(withDuration: 1.0,
         delay: 0,
         options: [.curveEaseIn, .repeat, .autoreverse],
         animations: {
         self.view.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
         }) { (finished : Bool) in
         print("completed")
         }
         */
        
        /*
         UIView.animate(withDuration: 0.5, delay: 0.5,
         usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [],
         animations: {
         self.imageView.center.y -= 30.0
         self.imageView.alpha = 0.5
         }, completion: nil)
         */
        
        /*
         UIView.beginAnimations(nil, context: nil)
         UIView.setAnimationDuration(1.0)
         if flag == 1
         {
         UIView.setAnimationTransition(.curlUp, for: self.view, cache: true)
         imageView.removeFromSuperview()
         self.view.addSubview(imageView1)
         flag = 0
         }
         else
         {
         UIView.setAnimationTransition(.curlUp, for: self.view, cache: true)
         imageView1.removeFromSuperview()
         self.view.addSubview(imageView)
         flag = 1
         }
         UIView.commitAnimations()
         NSLog("flag:\(flag)")
         */
        
        /*
        let ca = CATransition()
        ca.duration = 1.0
        ca.type = .push
        UIView.beginAnimations(nil, context: nil)
        if flag == 1.0{
            self.view.sendSubviewToBack(imageView)
            flag = 0.0
        }else{
            self.view.sendSubviewToBack(imageView1)
            flag = 1.0
        }
        self.view.layer.add(ca, forKey: "transitionViewAnimation")
         */
        
        if let touch = touches.first {
             let location = touch.location(in: self.view)
             let timing = UICubicTimingParameters(
                 animationCurve: .easeInOut)
             let animator = UIViewPropertyAnimator(duration: 2.0,
                                                   timingParameters:timing)
             
             animator.addAnimations {
                 let scaleTrans =
                     CGAffineTransform(scaleX: self.scaleFactor,
                                       y: self.scaleFactor)
                 let rotateTrans = CGAffineTransform(
                     rotationAngle: CGFloat(self.angle * .pi / 180))
                 
                 self.boxView!.transform =
                     scaleTrans.concatenating(rotateTrans)
                 
                 self.angle = (self.angle == 180 ? 360 : 180)
                 self.scaleFactor = (self.scaleFactor == 2 ? 1 : 2)
                 self.boxView?.backgroundColor = UIColor.purple
                 self.boxView?.center = location
             }
             
             animator.addCompletion {_ in
                 self.boxView?.backgroundColor = UIColor.green
             }
              animator.startAnimation()
        }
        
    }
    
}

