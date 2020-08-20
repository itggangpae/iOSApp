//
//  ViewController.swift
//  ControlTest
//
//  Created by Munseok Park on 2020/08/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage(named: "btn_01.png")
        let image2 = UIImage(named: "btn_02.png")
        
        //보통 때와 누르고 있을 때의 이미지를 설정
        button.setBackgroundImage(image1, for: .normal)
        button.setBackgroundImage(image2, for: .highlighted)
        button.setTitle("보통", for:  .normal)
        button.setTitle("클릭", for:  .highlighted)
        
        txtName.delegate = self
        txtAge.delegate = self
        
        // 텍스트 필드 속성 설정
        txtName.placeholder = "이름을 입력하세요" // 안내 메시지
        txtName.keyboardType = UIKeyboardType.alphabet // 키보드 타입 영문자 패드로
        txtName.keyboardAppearance = UIKeyboardAppearance.dark // 키보드 스타일 어둡게
        txtName.returnKeyType = UIReturnKeyType.join // 리턴키 타입은 "Join"
        txtName.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 "On"
        
        // 테두리 스타일 - 직선
        txtName.borderStyle = .line
        // 배경 색상
        txtName.backgroundColor = UIColor(white:0.87, alpha:1.0)
        // 수직 방향으로 텍스트가 가운데 정렬되도록
        txtName.contentVerticalAlignment = .center
        // 수평 방향으로 텍스트가 가운데 정렬되도록
        txtName.contentHorizontalAlignment = .center
        // 테두리 색상을 회색으로
        txtName.layer.borderColor = UIColor.darkGray.cgColor
        // 테두리 두께 설정 (단위: pt)
        txtName.layer.borderWidth = 2.0
        
        // 텍스트 필드를 최초 응답자로 지정
        txtName.becomeFirstResponder()
        
         NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillShow),
                    name: UIResponder.keyboardWillShowNotification,
                    object: nil)
        
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(self.keyboardWillHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil)

        
        
    }
    
    @IBAction func click(_ sender: Any) {
        let name = txtName.text! as String
        let age = txtAge.text! as String
        let str = "이름:\(name) 나이:\(age)"
        self.label.text = str;
        
    }
    
    //뷰를 터치했을 때 호출되는 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtName.resignFirstResponder()
        txtAge.resignFirstResponder()
    }
    
    
}

extension ViewController : UITextFieldDelegate{
       //텍스트 필드의 내용이 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        NSLog("텍스트 필드의 내용이 \(string)으로 변경됩니다")
        if Int(string) == nil {
            // 현재 텍스트 필드에 입력된 길이와 더해질 문자열 길이의 합이 10을 넘는다면 반영하지 않음
            if (textField.text?.count)! + string.count > 10 {
                return false
            } else {
                return true
            }
        } else { // 입력된 값이 숫자라면 false를 리턴
            return false
        }
    }
    
    // 텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        NSLog("텍스트 필드의 리턴키가 눌러졌습니다")
        return true
    }
    
    // 텍스트 필드 편집이 종료될 때 호출
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            NSLog("텍스트 필드의 편집이 종료됩니다.")
            return true // false를 리턴하면 편집이 종료되지 않는다.
        }
        
        // 텍스트 필드의 편집이 종료되었을 때 호출
        func textFieldDidEndEditing(_ textField: UITextField) {
            NSLog("텍스트 필드의 편집이 종료되었습니다.")
        }
    
    

    
    // 텍스트필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        NSLog("텍스트 필드의 편집이 시작됩니다.")
        return true // false를 리턴하면 편집되지 않는다.
    }
    
    // 텍스트 필드의 편집이 시작된 후 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NSLog("텍스트 필드의 편집이 시작되었습니다.")
    }
    
    // 텍스트 필드의 내용이 삭제될 때 호출
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        NSLog("텍스트 필드의 내용이 삭제됩니다")
        return true // false를 리턴하면 삭제되지 않는다.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           let originalRect = button.frame
           let moveRect = CGRect(x: originalRect.origin.x, y: originalRect.origin.y-50, width: originalRect.size.width, height: originalRect.size.height)
           button.frame = moveRect
       }
       
       @objc func keyboardWillHide(notification: NSNotification){
           let originalRect = button.frame
           let moveRect = CGRect(x: originalRect.origin.x, y: originalRect.origin.y+50, width: originalRect.size.width, height: originalRect.size.height)
           button.frame = moveRect
       }


}
