//
//  PageCell.swift
//  CollectionSwipe
//
//  Created by Munseok Park on 2020/08/20.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    //부모 인스턴스를 초기화 해야 커스터마이징 할 수 있음
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //클로저 기능으로 이미지 객체 만들어주기(내부에서 속성정의)
    let myImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "car00.jpg"))
        // 이속성은 autolayout을 이용할 수 있게한다.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //클로저 기능으로 textView객체 만들어주기(내부에서 속성정의)
    let myTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "컬렉션 뷰를 이용한 페이지 스와이프 처리", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\n 인터페이스 빌더 없이도 컬렉션 뷰를 만들 수 있습니다.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        //textView.text = "ios기초 레슨 프로그램"
        //textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    func setupLayout() {
        
        let containerView = UIView()
        containerView.backgroundColor = .yellow
        //현재 cell에 콘테이너 뷰 추가
        addSubview(containerView)
        // 오토레이아웃 활성화
        //이제 제약조건이 view 기준이 아니기 때문에 view를 빼줘야 한다.
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //부모뷰에 이미지 뷰 넣어주기
        containerView.addSubview(myImageView)
        
        myImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        myImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
}
