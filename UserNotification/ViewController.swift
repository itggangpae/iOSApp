//
//  ViewController.swift
//  UserNotification
//
//  Created by Munseok Park on 2020/08/15.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func click(_ sender: Any) {
        /*
        // 메세지창 객체 생성
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in // 확인 버튼
            self.result.text = "확인 버튼을 클릭했습니다"
        }
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        // 메시지창 실행
        self.present(alert, animated: false)
 */
        
        // 메세지 창 관련 객체 정의
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title:"확인", style: .default) { (_) in
            // 확인 버튼을 클릭했을 때 실행할 내용
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            if loginId == "root" && loginPw == "1234" {
                self.result.text = "로그인에 성공하셨습니다."
            } else {
                self.result.text = "아이디나 비밀번호가 틀렸습니다."
            }
        }
        
        // 정의된 액션 버튼 객체를 메세지창에 추가
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 아이디 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "아이디를 입력하세요" // 미리 보여줄 안내 메시지
            tf.isSecureTextEntry = false // 입력시 별표(*) 처리 안함
        })
        
        // 비밀번호 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "비밀번호를 입력하세요" // 미리 보여줄 안내 메시지
            tf.isSecureTextEntry = true // 입력시 별표(*) 처리함
        })
        self.present(alert, animated:false)


    }
    
}

