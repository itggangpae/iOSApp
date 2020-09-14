//
//  PhotoEditingViewController.swift
//  MyPhotoExt
//
//  Created by Munseok Park on 2020/09/13.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class PhotoEditingViewController: UIViewController, PHContentEditingController {
    
    var input: PHContentEditingInput?
    
    @IBOutlet weak var imageView: UIImageView!
    
    var displayedImage: UIImage?
    var imageOrientation: Int32?
    
    var currentFilter = "CIColorInvert"
    
    func performFilter(_ inputImage: UIImage, orientation: Int32?)
        -> UIImage?
    {
        var resultImage: UIImage?
        var cimage: CIImage
        
        cimage = CIImage(image: inputImage)!
        
        if let orientation = orientation {
            cimage = cimage.oriented(forExifOrientation: orientation)
        }
        
        if let filter = CIFilter(name: currentFilter) {
            filter.setDefaults()
            filter.setValue(cimage, forKey: "inputImage")
            
            switch currentFilter {
                
            case "CISepiaTone", "CIEdges":
                filter.setValue(0.8, forKey: "inputIntensity")
                
            case "CIMotionBlur":
                filter.setValue(25.00, forKey:"inputRadius")
                filter.setValue(0.00, forKey:"inputAngle")
                
            default:
                break
            }
            
            if let ciFilteredImage = filter.outputImage {
                let context = CIContext(options: nil)
                if let cgImage = context.createCGImage(ciFilteredImage,
                                                       from: ciFilteredImage.extent) {
                    resultImage = UIImage(cgImage: cgImage)
                }
            }
        }
        return resultImage
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sepiaSelected(_ sender: Any) {
        currentFilter = "CISepiaTone"
        if let image = displayedImage {
            imageView.image = performFilter(image,orientation: nil)
        }
    }
    
    @IBAction func monoSelected(_ sender: Any) {
        currentFilter = "CIPhotoEffectMono"
        if let image = displayedImage {
            imageView.image = performFilter(image,
                                            orientation: nil)
        }
    }
    
    @IBAction func invertSelected(_ sender: Any) {
        currentFilter = "CIColorInvert"
        if let image = displayedImage {
            imageView.image = performFilter(image,
                                            orientation: nil)
        }
    }
    
    
    //extension이 조정 데이터를 지원하는지 여부를 설정하는 메소드 - 1번째 호출되는 메소드
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        return false
    }
    
    //데이터에 대한 정보를 가져오는 메소드 - 2번째 호출되는 메소드
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        input = contentEditingInput
        
        if let input = input {
            displayedImage = input.displaySizeImage
            imageOrientation = input.fullSizeImageOrientation
            imageView.image = displayedImage
        }
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        DispatchQueue.global().async {
            // Create editing output from the editing input.
            //let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            if let input = self.input {
                let output = PHContentEditingOutput(contentEditingInput: input)
                
                let url = self.input?.fullSizeImageURL
                
                if let imageUrl = url,
                    let fullImage = UIImage(contentsOfFile: imageUrl.path),
                    let resultImage = self.performFilter(fullImage, orientation: self.imageOrientation) {
                    
                    if let renderedJPEGData =
                        resultImage.jpegData(compressionQuality: 0.9) {
                        try! renderedJPEGData.write(to:
                            output.renderedContentURL)
                    }
                    
                    let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: self.currentFilter, requiringSecureCoding: true)
                    
                    let adjustmentData =
                        PHAdjustmentData(formatIdentifier:
                            "cyberadam.cafe24.com",
                                         formatVersion: "1.0",
                                         data: archivedData)
                    
                    output.adjustmentData = adjustmentData
                }
                completionHandler(output)
            }
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }
    
    //편집을 완료한 후 호출되는 메소드
    func cancelContentEditing() {
    }
    
}
