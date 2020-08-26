//
//  ViewController.swift
//  FileHandling
//
//  Created by Munseok Park on 2020/08/25.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextField!
    
    var fileMgr: FileManager = FileManager.default
    var docsDir: String?
    var dataFile: String?

    var customPlist:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func writeText(_ sender: Any) {
        /*
        //Document 디렉토리 경로 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true)
        docsDir = dirPaths[0]
        
        //파일 경로 생성
        dataFile = docsDir! + "/datafile.dat"
        customPlist = docsDir! + "/custom.plist"
        
        //입력한 데이터를 문자열로 생성
        let str = textView.text
        let databuffer = str!.data(using: String.Encoding.utf8)
        
        //텍스트 파일에 기록
        fileMgr.createFile(atPath: dataFile!, contents: databuffer, attributes: nil)
        
        //프로퍼티 파일에 기록
        let data = NSMutableDictionary(contentsOfFile: customPlist!) ?? NSMutableDictionary()
        data.setValue(str, forKey:"name")
        data.write(toFile: customPlist!, atomically: true)
 */
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true)
        docsDir = dirPaths[0]
        dataFile = docsDir! + "/datafile.txt"
        print(dataFile!)
        var file : FileHandle? = FileHandle(forUpdatingAtPath: dataFile!)
        
        if file == nil {
            fileMgr.createFile(atPath:dataFile!, contents: nil, attributes:nil)
        }
        file = FileHandle(forUpdatingAtPath: dataFile!)
        let stringData = textView.text
        let data = (stringData! as NSString).data(using:String.Encoding.utf8.rawValue)
        file?.seekToEndOfFile()
        file?.write(data!)
        file?.closeFile()
        NSLog("file write success")


    }
    
    @IBAction func readText(_ sender: Any) {
        /*
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true)
        docsDir = dirPaths[0]
        
        dataFile = docsDir! + "/datafile.dat"
        customPlist = docsDir! + "/custom.plist"
        
        if fileMgr.fileExists(atPath: dataFile!) == false{
            textView.text = "파일이 존재하지 않습니다."
        }else{
            let databuffer = fileMgr.contents(atPath: dataFile!)
            let log = NSString(data: databuffer!, encoding: String.Encoding.utf8.rawValue)
            textView.text = log! as String
        }
        
        //프로퍼티 파일에 기록
        let data = NSMutableDictionary(contentsOfFile: customPlist!) ?? NSMutableDictionary()
        NSLog(data["name"] as! String)
         */
        
         let dirPaths = NSSearchPathForDirectoriesInDomains(
                    .documentDirectory, .userDomainMask, true)
        docsDir = dirPaths[0]
        dataFile = docsDir! + "/datafile.txt"
        print(dataFile!)
        let file : FileHandle? = FileHandle(forReadingAtPath: dataFile!)
                
        if file == nil {
                    textView.text = "읽을 파일이 없습니다"
        }else{
                    NSLog("file open success")
                    //file?.seekToFileOffset(5) //특정 오프셋에서
                    //file?.readDataOfLength(10) //특정 길이만큼 읽을때 사용
                    let databuffer = file?.readDataToEndOfFile() //내용 전체를 읽는다.
                    //화면에 보이게 하기 위해 NSData 를 String으로 변환해준다.
                    let out = NSString(data: databuffer!, encoding: String.Encoding.utf8.rawValue)
                    file?.closeFile()
                    textView.text = out! as String
        }

    }
}

