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
    
    //Get Info News
    func getNews(completion: @escaping (_ news: [NewDataModel])->Void) {
        let url = "getnews"
        apiService.get(url: url) { (json, error) in
            if error == nil{
                var news = [NewDataModel]()
                json?["data"].array?.forEach({ (json) in
                    let new = NewDataModel(json: json)
                    news.append(new)
                })
                completion(news)
            }
            else{
                print("Error:\(error?.localizedDescription)")
            }

        }
    }//end getNews
}
