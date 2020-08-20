//
//  SecondViewController.swift
//  SwitchViewController
//
//  Created by Munseok Park on 2020/08/17.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblSecond: UILabel!
    
    var data : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblSecond.text = data

        // Do any additional setup after loading the view.
    }
    
    @IBAction func movePrev(_ sender: Any) {
        let mainViewController =  self.presentingViewController as! ViewController
        mainViewController.subData = "다시 돌아옴"
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.presentingViewController?.dismiss(animated: true)
    }

    
}
