//
//  AboutusService.swift
//  PPCApp
//
//  Created by NguoiNb on 4/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class AboutusService: BaseService {
    static let share = AboutusService()
    func getDataService(indexpage:String,completion:@escaping ([AboutusDataModels])->Void){
        let url:String = "aboutus/all" + indexpage
        var AboutusDatas = [AboutusDataModels]()
        apiService.get(url: url) { (json, err) in
            if err == nil{
                let json = json?["data"]
                json?.array?.forEach({ (json) in
                    let aboutus = AboutusDataModels(json: json)
                    AboutusDatas.append(aboutus)
                })
                completion(AboutusDatas)
            }
            else{
                completion([])
            }
        }
    }
    
}
