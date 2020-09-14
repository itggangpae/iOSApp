//
//  MyView.swift
//  Draw2D
//
//  Created by Munseok Park on 2020/09/14.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class MyView: UIView {
     /*
        override func draw(_ rect: CGRect) {
            print("시작")
            // 글자 출력
            let str = "텍스트 드로윙"
            let attr = [NSAttributedString.Key.foregroundColor:UIColor.red,
                        NSAttributedString.Key.font:UIFont.systemFont(ofSize: 30)]
            (str as NSString).draw(at: CGPoint(x:10, y:50), withAttributes: attr)
            
            // 이미지 그리기
            if let image = UIImage(named: "account@2x.jpg") {
                image.draw(in: CGRect(x: 50, y: 100, width: 100, height:100))
            }
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 20, y: 120))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 200, y: 120))
            UIColor.white.setStroke()

            path.stroke()
            
            let r = CGRect(x: 200, y: 200, width: 100, height: 100)
            let roundRectPath = UIBezierPath(roundedRect: r,
                                                     cornerRadius: 30)
            UIColor.red.setStroke()
            roundRectPath.stroke()
            UIColor.lightGray.setFill()
            roundRectPath.fill()

            let ovalRect = CGRect(x: 10, y: 50, width: 300, height: 200)
            let ovalPath = UIBezierPath(ovalIn: ovalRect)
            ovalPath.stroke()
            let arcCenter = CGPoint(x: 150, y: 200)
            let arcPath = UIBezierPath(arcCenter: arcCenter, radius: 100,
                                   startAngle: CGFloat.pi/4, endAngle: CGFloat.pi/4*3, clockwise: true)
            arcPath.stroke()


        }
    
*/
    
    override func draw(_ rect:CGRect){
        /*
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(2.0)
        context?.setStrokeColor(CGColor.init(srgbRed: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        
        context?.move(to: CGPoint(x: 30, y: 30))
        context?.addLine(to: CGPoint(x: 300, y:400))
       
        context?.addRect(CGRect(x: 60, y: 170, width: 200, height: 80))
        context?.strokePath()
        
        
        context?.setFillColor(CGColor.init(srgbRed: 1.0, green: 1.0, blue: 0.0, alpha: 1.0))
        context?.fillEllipse(in: CGRect(x: 60, y: 170, width: 200, height: 80))
 */
        if let myimage = UIImage(named: "cat.png"),
            let sepiaFilter = CIFilter(name: "CISepiaTone") {
            
            let cimage = CIImage(image: myimage)
            
            sepiaFilter.setDefaults()
            sepiaFilter.setValue(cimage, forKey: "inputImage")
            sepiaFilter.setValue(NSNumber(value: 0.8 as Float),
                                 forKey: "inputIntensity")
            
            let image = sepiaFilter.outputImage
            
            let context = CIContext(options: nil)
            
            let cgImage = context.createCGImage(image!,
                                                from: image!.extent)
            
            let resultImage = UIImage(cgImage: cgImage!)
            let imageRect = UIScreen.main.bounds
            resultImage.draw(in: imageRect)
        }

    }
 
}
