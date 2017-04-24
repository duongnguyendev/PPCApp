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
    func getNews(indexPage: String,completion: @escaping (_ news: [NewDataModel]?,_ currentPage: Int,_ next_page_url: String)->Void){
        let url = "news/all?page=" + indexPage
        self.fetchNewsAll(pageUrl: url) { (news, errMess, currentPage, next_page_url) in
            if errMess == 1{
                completion(news,currentPage,next_page_url)
            }
        }
    }
    func fetchNewsAll(pageUrl: String,callback: @escaping NewsCallback){
        let url = pageUrl
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
                DispatchQueue.main.async {
                    return callback(news,errMess,currentPage,nextPage)
                }
            }else{
                
            }
        }
    }

}
