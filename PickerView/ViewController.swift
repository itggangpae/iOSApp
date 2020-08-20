//
//  ViewController.swift
//  PickerView
//
//  Created by Munseok Park on 2020/08/15.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pickerImage: UIPickerView!
    @IBOutlet weak var lblImageName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageArray = [UIImage?]()
    var imageFileName = [ "red0.jpg","red1.jpg","red2.jpg","red3.jpg","red4.jpg" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerImage.delegate = self
        pickerImage.dataSource = self
        for i in 0 ..< imageFileName.count {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageName.text = imageFileName[0]
        imageView.image = imageArray[0]
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return imageFileName[row]
    //    }
    
   
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image:imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageView
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageName.text = imageFileName[row]
        imageView.image = imageArray[row]
    }
}
