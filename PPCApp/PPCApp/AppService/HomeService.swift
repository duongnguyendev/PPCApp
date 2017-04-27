//
//  HomeService.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/15/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
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
        self.fetchHomesAll(pageUrl: url!) { (homes, errMess, currentPage, next_page_url) in
            if errMess == 1{
                completion(homes,currentPage,next_page_url)
            }
        }
    }
    func fetchHomesAll(pageUrl: String,callback: @escaping HomeCallback){
        let url = pageUrl
        apiService.get(url: url) { (json, error) in
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
    func fetchPlaces(pageUrl: String,callback: @escaping PlaceCallback){
        let url = pageUrl
        apiService.get(url: url) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                var places = [Place]()
                json?["data"].array?.forEach({ (jsons) in
                    let id = jsons["id"].number ?? -1
                    let name = jsons["name"].string ?? ""
                    let place = Place.init(id: id, name: name)
                    
                    places.append(place)
                })
                DispatchQueue.main.async {
                    return callback(places,errMess)
                }
            }else{
                
            }
        }
    }
    
    func fetchHomesFilter(id_projectType: NSNumber,id_country: NSNumber,id_province: NSNumber,id_district: NSNumber,type: NSNumber,callback: @escaping HomeCallback){
        let url = "property/filter"
        let parameters = [
            "id_project": id_projectType,
            "id_country": id_country,
            "id_province": id_province,
            "id_district": id_district,
            "type": type
        ]
        apiService.post(url: url, parameters: parameters) { (json, error) in
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
            }
        }
    }
    
    func fetchHomesSearch(textSearch: String,indexPgae: Int,callback: @escaping SearchCallback){
        let url = "property/search"
        let parameters = [
            "search": textSearch,
            "page": indexPgae
        ] as [String : Any]
        apiService.post(url: url, parameters: parameters) { (json, error) in
            if error == nil{
                let errMess = json?["message"].int ?? -1
                let currentPage = json?["data"]["current_page"].int ?? -1
                let nextPage = json?["data"]["next_page_url"].string ?? ""
                var searchs = [HomeDataModel]()
                json?["data"]["data"].array?.forEach({ (jsons) in
                    let search = HomeDataModel(json: jsons)
                    searchs.append(search)
                })
                DispatchQueue.main.async {
                    return callback(searchs,errMess,currentPage,nextPage)
                }
            }
        }
    }
    
}
