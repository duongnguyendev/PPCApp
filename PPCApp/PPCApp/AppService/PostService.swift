//
//  PostService.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    
}

