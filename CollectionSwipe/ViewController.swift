//
//  ViewController.swift
//  CollectionSwipe
//
//  Created by Munseok Park on 2020/08/20.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //배경색을 흰색
        collectionView?.backgroundColor = .white
        //collectionView에 cell을 등록해주는 작업, 여기서는 직접 만든 cell을 넣어주었고, 아이디를 설정해 주었다.
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "PageCell")
        //페이징 기능 허용
        collectionView?.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //컬렉션 뷰의 cell 개수 지정.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    //컬렉션 뷰의 cell을 구성하는 함수
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //위에서 등록해준 커스텀 셀을 가져와서 리턴해줌
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath)
        return cell
    }
    //커스텀 셀의 크기를 view에 꽉차게 해주었다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
