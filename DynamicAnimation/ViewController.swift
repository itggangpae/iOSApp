//
//  ViewController.swift
//  DynamicAnimation
//
//  Created by Munseok Park on 2020/09/15.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

var square: UIView!
var snap: UISnapBehavior!
var animator: UIDynamicAnimator!


class GravityView: UIView {
    
    lazy var squareView: UIView = { [unowned self] in
        let sv = UIView(frame: CGRect(x:100, y:100, width:100, height:100))
        addSubview(sv)
        return sv
        }()
    
    lazy var gravity = { [unowned self] in
        return UIGravityBehavior(items: [self.squareView])
        }()
    
    lazy var animator: UIDynamicAnimator = { [unowned self] in
        return UIDynamicAnimator(referenceView: self)
        }()
}




class AttachView: UIView {
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(squareView)
        animator.addBehavior(attach)
        animator.addBehavior(gravity)
    }
    lazy var animator: UIDynamicAnimator = { [unowned self] in
        let anim = UIDynamicAnimator(referenceView: self)
        return anim
        }()
    
    lazy var squareView: UIView = {
        let s = UIView(frame: CGRect(x:100, y:100, width:100, height:100))
        s.backgroundColor = UIColor.blue
        s.layer.cornerRadius = 28.0
        return s
    }()
    
    lazy var gravity = { [unowned self] in
        return UIGravityBehavior(items: [self.squareView])
        }()
    
    lazy var attach: UIAttachmentBehavior = { [unowned self] in
        let a = UIAttachmentBehavior(item: self.squareView, attachedToAnchor: CGPoint(x:300, y:0))
        return a
        }()
    
}

class PushView: UIView {
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
    }
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(redView)
        addSubview(blueView)
        let continuousPush: UIPushBehavior = UIPushBehavior(items:[self.redView], mode:.continuous)
        continuousPush.pushDirection = CGVector(dx: 1.0, dy: 0.0)
        let instantaneousPush: UIPushBehavior = UIPushBehavior(items:[self.blueView], mode:.instantaneous)
        instantaneousPush.pushDirection = CGVector(dx: 0.0, dy: 1.0)
        animator.addBehavior(continuousPush)
        animator.addBehavior(instantaneousPush)
    }
    
    lazy var animator: UIDynamicAnimator = { [unowned self] in
        let anim = UIDynamicAnimator(referenceView: self)
        return anim
        }()
    
    
    var blueView: UIView = {
        let v = UIView(frame: CGRect(x:220, y:100, width:50, height: 50))
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    var redView: UIView = {
        let v = UIView(frame: CGRect(x:40, y:100, width:50, height:50))
        v.backgroundColor = UIColor.red
        return v
    }()
    
    
}
class ViewController: UIViewController {
    
    var blueBoxView: UIView?
    var redBoxView: UIView?
    
    var animator: UIDynamicAnimator?
    
    var currentLocation: CGPoint?
    var attachment: UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         let myView = GravityView()
         myView.frame = UIScreen.main.bounds
         self.view.addSubview(myView)
         myView.squareView.backgroundColor = UIColor.blue
         myView.animator.addBehavior(myView.gravity)
         
         let collision = UICollisionBehavior(items:[myView.squareView])
         collision.translatesReferenceBoundsIntoBoundary = true
         myView.animator.addBehavior(collision)
         
         let itemBehavior = UIDynamicItemBehavior(items: [myView.squareView])
         itemBehavior.elasticity = 0.8
         myView.animator.addBehavior(itemBehavior)
         */
        
        /*
         square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
         square.backgroundColor = UIColor.gray
         view.addSubview(square)
         animator = UIDynamicAnimator(referenceView: view)
         */
        
        /*
         let myView = AttachView(frame: UIScreen.main.bounds)
         self.view.addSubview(myView)
         */
        
        /*
         let myView = PushView(frame: UIScreen.main.bounds)
         self.view.addSubview(myView)
         */
        
        var frameRect = CGRect(x: 10, y: 20, width: 80, height: 80)
        blueBoxView = UIView(frame: frameRect)
        blueBoxView?.backgroundColor = UIColor.blue
        
        frameRect = CGRect(x: 150, y: 20, width: 60, height: 60)
        redBoxView = UIView(frame: frameRect)
        redBoxView?.backgroundColor = UIColor.red
        
        self.view.addSubview(blueBoxView!)
        self.view.addSubview(redBoxView!)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: [blueBoxView!,
                                                redBoxView!])
        let vector = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = vector
        
        animator?.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [blueBoxView!,
                                                    redBoxView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collision)
        
        let behavior = UIDynamicItemBehavior(items: [blueBoxView!])
        behavior.elasticity = 0.5
        animator?.addBehavior(behavior)
        
        let boxAttachment = UIAttachmentBehavior(item: blueBoxView!,
                                                         attachedTo: redBoxView!)
        boxAttachment.frequency = 4.0
        boxAttachment.damping = 0.0
                
        animator?.addBehavior(boxAttachment)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let theTouch = touches.first, let blueBox = blueBoxView {
            
            currentLocation = theTouch.location(in: self.view) as CGPoint?
            
            if let location = currentLocation {
                let offset = UIOffset(horizontal: 20, vertical: 20)
                attachment = UIAttachmentBehavior(item: blueBox,
                                                  offsetFromCenter: offset,
                                                  attachedToAnchor: location)
            }
            
            if let attach = attachment {
                animator?.addBehavior(attach)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let theTouch = touches.first {
            
            currentLocation = theTouch.location(in: self.view)
            
            if let location = currentLocation {
                attachment?.anchorPoint = location
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         if (snap != nil) {
         animator.removeBehavior(snap)
         }
         let touch = touches.first
         
         snap = UISnapBehavior(item: square, snapTo: touch!.location(in: self.view))
         animator.addBehavior(snap)
         */
        
        if let attach = attachment {
            animator?.removeBehavior(attach)
        }
    }
}

