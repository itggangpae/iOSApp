//
//  ContentViewController.swift
//  PageView
//
//  Created by Munseok Park on 2020/08/20.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    var subData : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let imageName = subData{
            imgView.image = UIImage(named: imageName)
        }
    }
    
    
}
