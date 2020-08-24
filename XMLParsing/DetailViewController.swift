//
//  DetailViewController.swift
//  XMLParsing
//
//  Created by Munseok Park on 2020/08/21.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var tvSummary: UITextView!
    
    var book : Book?

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = book!.title
        lblAuthor.text = book!.author
        tvSummary.text = book!.summary
        self.title = book!.title

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
