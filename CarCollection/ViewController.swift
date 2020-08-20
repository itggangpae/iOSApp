//
//  ViewController.swift
//  CarCollection
//
//  Created by Munseok Park on 2020/08/20.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var images : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...24{
            let imgName : String = String(format: "car%02i.jpg", i)
            images.append(imgName)
        }
        
    }
    
    
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //셀의 개수를 설정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //셀의 개수를 설정
        return images.count
    }
    
    //셀 구성하기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    // 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewCellWithd = collectionView.frame.width / 3 - 1
        return CGSize(width: collectionViewCellWithd, height: collectionViewCellWithd)
    }
    
    
    //위아래 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //옆 라인 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath){
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.cyan.cgColor
            cell?.layer.borderWidth = 3.0
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath){
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = nil
            cell?.layer.borderWidth = 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.yellow.cgColor
            cell?.layer.borderWidth = 5.0
    }
    
     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = UIColor.yellow.cgColor
            cell?.layer.borderWidth = 0.0
     }


}
