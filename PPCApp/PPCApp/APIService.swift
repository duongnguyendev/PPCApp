//
//  APIServer.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/21/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class APIService {
    
    static let shareInstanse = APIService()
    
    //GET JSON OF NEWS
    func getNews(completion: @escaping (_ news: [NewDataModel]) ->Void){
        Alamofire.request(APIKey.keyNews).responseJSON { response in
            if let newsJSON = response.result.value {
                var news = [NewDataModel]()
                let json = JSON(newsJSON)
                json["data"].array?.forEach({ (json) in
                    let new = NewDataModel(json: json)
                    news.append(new)
                })
                //print("Connected")
                completion(news)
                
            }
            else{
                print("Not Connected")
            }
        }
    }
    
    
}
