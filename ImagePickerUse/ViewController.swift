//
//  ViewController.swift
//  ImagePickerUse
//
//  Created by Munseok Park on 2020/09/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

import Alamofire
import MobileCoreServices

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false
    
    
    @IBAction func takeCamera(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            let msgAlert = UIAlertController(title: "카메라", message: "카메라를 사용할 수 없음", preferredStyle: .alert)
            msgAlert.addAction(UIAlertAction(title: "확인", style:.default))
            present(msgAlert, animated: true)
        }
    }
    
    @IBAction func takeVideo(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            let msgAlert = UIAlertController(title: "카메라", message: "카메라를 사용할 수 없음", preferredStyle: .alert)
            msgAlert.addAction(UIAlertAction(title: "확인", style:.default))
            present(msgAlert, animated: true)
        }
    }
    
    @IBAction func readVideo(_ sender: Any) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            let msgAlert = UIAlertController(title: "카메라", message: "카메라를 사용할 수 없음", preferredStyle: .alert)
            msgAlert.addAction(UIAlertAction(title: "확인", style:.default))
            present(msgAlert, animated: true)
        }
    }
    
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController( )
        picker.sourceType = .photoLibrary // 이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true // 이미지 편집 기능 On
        
        // 이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
        
        picker.delegate = self
        
    }
    
    @IBAction func addServer(_ sender: Any) {
        let addAlert = UIAlertController(title: "데이터 추가", message: "추가할 데이터를 입력하세요", preferredStyle: .alert)
        
        addAlert.addTextField(){(tf) -> Void in tf.placeholder = "추가할 항목의 이름을 입력하세요"}
        addAlert.addTextField(){(tf) -> Void in tf.placeholder = "추가할 항목의 가격을 입력하세요"
            tf.keyboardType = .numberPad}
        addAlert.addTextField(){(tf) -> Void in tf.placeholder = "추가할 항목의 설명을 입력하세요"}
        
        addAlert.addAction(UIAlertAction(title: "취소", style:.cancel))
        addAlert.addAction(UIAlertAction(title: "추가", style:.default){
            (_) in
            
            let itemname = addAlert.textFields?[0].text
            let price = addAlert.textFields?[1].text
            let description = addAlert.textFields?[2].text
            
            let parameterS: Parameters = ["itemname": itemname!,"price":price!, "description":description!]
            AF.upload(
                multipartFormData: { multipartFormData in
                    for (key, value) in parameterS {
                        if let temp = value as? String {
                            multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                        }
                    }
                    let image = self.imgView.image
                    if image != nil{
                        multipartFormData.append(image!.pngData()!, withName: "pictureurl" , fileName: "file.png", mimeType: "image/png")
                    }
            },to: "http://cyberadam.cafe24.com/item/insert", method: .post , headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if let jsonObject = response.value as? [String : Any]{
                        let result = jsonObject["result"]! as? Bool
                        var msg :  String?
                        if result! {
                            msg = "삽입 성공"
                        }else{
                            msg = "삽입 실패"
                        }
                        
                        let msgAlert = UIAlertController(title: "데이터 삽입", message: msg, preferredStyle: .alert)
                        msgAlert.addAction(UIAlertAction(title: "확인", style:.default))
                        self.present(msgAlert, animated: true)
                    }
            }
        })
        
        self.present(addAlert, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

//이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate{
    // 이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: false) { () in
            // 알림창 호출
            let alert = UIAlertController(title: "",
                                          message: "이미지 선택을 취소되었습니다",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imgView.image = captureImage
            self.dismiss(animated: true, completion: nil)
        }
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
        else{
            // 이미지 피커 컨트롤러 창 닫기
            picker.dismiss(animated: false) { () in
                // 이미지를 이미지 뷰에 표시
                let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                self.imgView.image = img
            }
        }
    }
}

extension ViewController: UINavigationControllerDelegate {
}
