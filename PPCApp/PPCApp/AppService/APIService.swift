//
//  BaseAPIService.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 3/22/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
class APIService: NSObject {
    static let shared = APIService()
    
    func fetchHomesAll(pageUrl: String,callback: @escaping HomeCallback){
        let url = pageUrl
        self.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                let currentPage = json?["data"]["current_page"].int ?? -1
                let nextPage = json?["data"]["next_page_url"].string ?? ""
                var homes = [HomeDataModel]()
                json?["data"]["data"].array?.forEach({ (jsons) in
                    let home = HomeDataModel(json: jsons)
                    homes.append(home)
                })
                DispatchQueue.main.async {
                    return callback(homes,errMess,currentPage,nextPage)
                }
            }else{
                
            }

        }
    }
    func fetchNewsAll(pageUrl: String,callback: @escaping NewsCallback){
        let url = pageUrl
        self.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                let currentPage = json?["data"]["current_page"].int ?? -1
                let nextPage = json?["data"]["next_page_url"].string ?? ""
                var news = [NewDataModel]()
                json?["data"]["data"].array?.forEach({ (jsons) in
                    let new = NewDataModel(json: jsons)
                    news.append(new)
                })
                DispatchQueue.main.async {
                    return callback(news,errMess,currentPage,nextPage)
                }
            }else{
                
            }
        }
    }
    
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
    func getImage(url: String,completion: @escaping ((UIImage?,Error?)->())){
        Alamofire.request(url).responseImage { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
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
