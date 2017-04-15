//
//  HomeService.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class HomeService: BaseService {
    static let shared = HomeService()
    func getHomes(indexPage: String,type: Int,
                  completion: @escaping (_ homes: [HomeDataModel]?,_ currentPage: Int,_ next_page_url: String)->Void){
        let url: String?
        if type == 0{
            url = "property/sale?page=" + indexPage
        }else{
            url = "property/rent?page=" + indexPage
        }
        apiService.fetchHomesAll(pageUrl: url!) { (homes, errMess, currentPage, next_page_url) in
            if errMess == 1{
                completion(homes,currentPage,next_page_url)
            }
        }
    }

    
}
