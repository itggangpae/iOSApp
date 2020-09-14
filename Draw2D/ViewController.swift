//
//  ViewController.swift
//  Draw2D
//
//  Created by Munseok Park on 2020/09/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = MyView()
        myView.frame = UIScreen.main.bounds
        self.view.addSubview(myView)
        
    }
}

