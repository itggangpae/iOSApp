//
//  ViewController.swift
//  PageView
//
//  Created by Munseok Park on 2020/08/20.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //페이지 뷰 컨트롤러
    var pageController : UIPageViewController!
    //이미지 파일이름
    var ar = Array<String>()
    //페이지 뷰 컨트롤러에 대입될 뷰 컨트롤러
    var tutorialPages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1...9
        {
            ar.append("image\(i).png")
        }
        
        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .vertical, options: [:])
        pageController.dataSource = self;
        pageController.view.frame = view.frame
        
        let initialViewController = viewControllerAtIndex(index: 0)
        tutorialPages.append(initialViewController!)
        
        
        pageController.setViewControllers(tutorialPages, direction: .forward, animated: false, completion: nil)

        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
       
        
    }
    
    //인덱스를 넘겨주면 ContentViewController를 생성해서 데이터를 넘겨주고 리턴하는 사용자 정의 메소드
    func viewControllerAtIndex(index:Int) -> ContentViewController?
    {
        if ar.count == 0 || index >= ar.count{
            return nil
        }
        
        let dataViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        NSLog("index\(index)")
        dataViewController.subData = ar[index]
        return dataViewController;
    }
    
    //하위 뷰 컨트롤러를 가지고 이 하위 뷰 컨트롤러가 몇 번째 뷰인지 리턴하는 메소드
    func indexOfViewController(viewController:ContentViewController) -> Int?
    {
        NSLog("\(viewController.subData!)")
        return ar.firstIndex(of: viewController.subData!)
    }
}


extension ViewController:UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController:viewController as! ContentViewController)
        if index == nil {
            return nil;
        }
        
        index = index! + 1
        if index == ar.count{
            return nil;
        }
        return viewControllerAtIndex(index: index!);
    }
    
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController:viewController as! ContentViewController)
        if index == nil {
            return nil;
        }
        
        index = index! - 1
        if index == -1{
           return nil
        }
        return viewControllerAtIndex(index: index!);
    }
}
