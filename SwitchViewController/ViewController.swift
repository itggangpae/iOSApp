//
//  ViewController.swift
//  SwitchViewController
//
//  Created by Munseok Park on 2020/08/17.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblMain: UILabel!
    
    var subData : String!{
            didSet {
                viewIfLoaded?.setNeedsLayout()
            }
        }
    
    override func viewWillLayoutSubviews(){
        if let text = subData{
            lblMain.text = text
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func moveNext(_ sender: Any) {
        let second = self.storyboard!.instantiateViewController(withIdentifier:"SecondViewContoller") as! SecondViewController
        second.data = "상위 뷰 컨트롤러에서 전달하는 데이터"
        second.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        self.present(second, animated:true){() in print("두번째 뷰 컨트롤러로 이동 후 실행")}
        print("두번째 뷰 컨트롤러로 이동 후 실행된다는 보장이 없습니다.")
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SecondViewController
        destination.data = "세그웨이를 이용해서 이동했습니다."
    }

    @IBAction func returned(segue: UIStoryboardSegue){
         lblMain.text = "원래 자리로 돌아왔습니다."
     }
    
    @IBAction func moveByNavi(_ sender: Any) {
           guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
           else{
               return
           }
           self.navigationController?.pushViewController(detailViewController, animated: true)

       }

}

