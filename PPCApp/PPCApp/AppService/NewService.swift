//
//  NewService.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class NewService: BaseService{
    static let shared = NewService()
    func getNews(indexPage: Int,completion: @escaping (([NewDataModel]?,Int?,Int?,String?)->())){
        let url = "news/all?page=\(indexPage)"
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                let currentPage = json?["data"]["current_page"].int ?? -1
                let nextPage = json?["data"]["next_page_url"].string ?? ""
                var news = [NewDataModel]()
                json?["data"]["data"].array?.forEach({ (jsons) in
                    let new = NewDataModel(json: jsons)
                    news.append(new)
                })
                completion(news,errMess,currentPage,nextPage)
            }
        }
    }
    
    

}
