//
//  ViewController.swift
//  IOSSocket
//
//  Created by Munseok Park on 2020/08/21.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfMsg: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    let host = "192.168.1.95"
    let port = 9999
    var client: TCPClient?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client = TCPClient(address: host, port: Int32(port))
    }
    
    @IBAction func send(_ sender: Any) {
       
        guard let client = client else { return }
        
        switch client.connect(timeout: 60) {
        case .success:
            appendToTextField(string: "Connected to host \(client.address)")
            if let response = sendRequest(string: "\(tfMsg.text!)\n\n", using: client) {
                appendToTextField(string: "Response: \(response)")
            }
        case .failure(let error):
            appendToTextField(string: String(describing: error))
        }
        
    }
    
    private func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextField(string: "Sending data ... ")
        
        switch client.send(string: string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextField(string: String(describing: error))
            return nil
        }
    }
    
    private func readResponse(from client: TCPClient) -> String? {
        sleep(3)
        guard let response = client.read(1024*10)
            else { return nil }
        
        return String(bytes: response, encoding: .utf8)
    }
    
    private func appendToTextField(string: String) {
        NSLog(string)
        textView.text = textView.text.appending("\n\(string)")
    }
}

