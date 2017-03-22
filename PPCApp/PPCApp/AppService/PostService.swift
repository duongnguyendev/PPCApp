//
//  PostService.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import SwiftyJSON

class PostService: NSObject {
    
    static let shared = PostService()
    
    override init() {
        super.init()
    }
    
    func getPosts(completion: @escaping ((JSON?, Error?)->())){
        let url = "resort/all"
        APIService.shared.get(url: url) { (data, error) in
            if error == nil {
                completion(data, nil)
            }else{
                completion(nil, error)
            }
        }
    }
}
