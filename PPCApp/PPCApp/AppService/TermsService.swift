//
//  TermsService.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class TermsService:BaseService{
    static let share = TermsService()
    func getTermsData(indexpage:String,completion: @escaping ([TermsModel])->Void){
        let url:String = "terms" + indexpage
        var Termss = [TermsModel]()
      
        apiService.get(url: url) { (jsons, err) in
            if err == nil{
                let json = jsons?["data"].array
                json?.forEach({ (js) in
                    let term = TermsModel(json: js)
                    Termss.append(term)
                })
                
                completion(Termss)
            }
            else{
                completion([])
            }
        }
    }
}
