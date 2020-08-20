//
//  ViewController.swift
//  FIrstSDK
//
//  Created by Munseok Park on 2020/08/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func onClick1(_ sender: Any) {
        self.view.backgroundColor = UIColor.red;
    }
    @IBAction func onClick2(_ sender: Any) {
        self.view.backgroundColor = UIColor.blue;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Hello SDK"
    }
}

