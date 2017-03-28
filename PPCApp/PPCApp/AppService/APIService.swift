//
//  BaseAPIService.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIService: NSObject {
    func post(url : String, parameters: Parameters, completion: @escaping ((JSON?, Error?)->())){
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, nil)
                print("JSON: \(json)")
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    func get(url : String, completion:@escaping ((JSON?,Error?)->())){
        Alamofire.request(self.urlFrom(request: url)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, nil)
                print("JSON: \(json)")
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    func urlFrom(request: String) -> String{
        return LanguageManager.shared.localized(string: "domainPPC")! + request
    }
    
}

class BaseService: NSObject {
    
    let apiService = APIService()
    
    override init() {
        super.init()
    }
    
    
}
