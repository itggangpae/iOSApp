//
//  AttractionDetailViewController.swift
//  NaviWeb
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import WebKit

class AttractionDetailViewController: UIViewController {
    var webSite: String?

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let address = webSite {
             let webURL = URL(string: address)
             let urlRequest = URLRequest(url: webURL!)
             webView.load(urlRequest)
        }

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
