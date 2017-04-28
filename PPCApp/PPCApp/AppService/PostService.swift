//
//  PostService.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import SwiftyJSON
import Photos
class PostService: BaseService {
    
    static let shared = PostService()
    func getPosts(completion: @escaping ((JSON?, Error?)->())){
        let url = "resort/all"
        apiService.get(url: url) { (data, error) in
            if error == nil {
                completion(data, nil)
            }else{
                completion(nil, error)
            }
        }
    }
    
    func fetchPhotos(completion: (_ images: [UIImage])-> Void){
        let imgManager = PHImageManager.default()
        
        let requestOpption = PHImageRequestOptions()
        requestOpption.isSynchronous = true
        requestOpption.deliveryMode = .highQualityFormat
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult: PHFetchResult? = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOption)
        if let mfetchResult = fetchResult {
            if mfetchResult.count > 0{
                var imagesPhoto = [UIImage]()
                for index in 0..<mfetchResult.count{
                    imgManager.requestImage(for: mfetchResult.object(at: index), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOpption, resultHandler: { (image,error) in
                        imagesPhoto.append(image!)
                    })
                }
                completion(imagesPhoto)
            }else{
                
                print("You not go photo")
            }
        }
    }
    
}

