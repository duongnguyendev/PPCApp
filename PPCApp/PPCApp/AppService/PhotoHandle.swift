//
//  PhotoHandle.swift
//  PPCApp
//
//  Created by Macbook Solution on 5/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import Photos
class PhotoHandle : NSObject{
    static let shared = PhotoHandle()
    
    func fetchPhotos(completion: (_ images: [UIImage])-> Void){
        let imgManager = PHImageManager.default()
        let requestOpption = PHImageRequestOptions()
        requestOpption.isSynchronous = true
        requestOpption.deliveryMode = .highQualityFormat
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOption){
            if fetchResult.count > 0{
                var imagesPhoto = [UIImage]()
                for index in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: index), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOpption, resultHandler: { (image,error) in
                        imagesPhoto.append(image!)
                    })
                }
                completion(imagesPhoto)
            }else{
                print("You not go photo")
            }
        }
    }
    func resizePhoto(image: UIImage,targetSize: CGSize)-> UIImage{
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 2.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
