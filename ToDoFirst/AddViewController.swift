//
//  AddViewController.swift
//  ToDoFirst
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var tfItem: UITextField!
    @IBAction func add(_ sender: Any) {
        items.append(tfItem.text!)
        itemsImageFile.append("clock.png")
        tfItem.text=""
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
