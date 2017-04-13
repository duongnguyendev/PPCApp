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
    
    func getNew(indexPage: String,completion: @escaping (NewDataModel?)->Void){
        let url = "news/all?page=" + indexPage
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let json = json?["data"]
                let new = NewDataModel(json: json!)
                completion(new)
            }else{
                completion(nil)
            }
        }
        
    }
}
