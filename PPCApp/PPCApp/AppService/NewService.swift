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
        apiService.fetchNewsAll(pageUrl: url) { (news, errMess, currentPage, next_page_url) in
            if errMess == 1{
                completion(news,currentPage,next_page_url)
            }
        }
                
    }
}
