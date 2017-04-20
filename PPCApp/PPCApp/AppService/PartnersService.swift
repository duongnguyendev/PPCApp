//
//  PartnersService.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/29/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class PartnersService: BaseService {
    static let shared = PartnersService()
    
    func getPartnersdata(indexpage:String,completion: @escaping (([PartnersDataModel])->Void)){
        let url:String = "partners" + indexpage
        var Partners = [PartnersDataModel]()
        apiService.get(url: url) { (json, err) in
            if err == nil{
                let json = json?["data"]
                json?.array?.forEach({ (jsons) in
                    let partner = PartnersDataModel(json: jsons)
                    Partners.append(partner)
                    
                })
                completion(Partners)
               
            }
            else{
                completion([])
            }
        }
    }
    
//    func getPartners(complention: ([PartnersDataModel]) ->Void){
//        print("SSSSSSS")
//        var partners = [PartnersDataModel]()
//        partners.append(addPartners(logo: "FLC.png", company: "CÔNG TY CỔ PHẦN TẬP ĐOÀN FLC", field: "Bất Động Sản"))
//        partners.append(addPartners(logo: "Centurion.png",company: "CENTURION COPORATION LIMITED",field: "Bất Động Sản"))
//        partners.append(addPartners(logo: "Colliers.png",company: "COLLIERS INTERNATIONAL",field: "Bất Động Sản"))
//        partners.append(addPartners(logo: "CapitalLand.png",company: "CÔNG TY CỔ PHẦN TẬP ĐOÀN CAPITALLAND",field: "Bất Động Sản"))
//        
//        complention(partners)
//    }
//    
//    func addPartners(logo: String,company: String,field: String)-> PartnersDataModel{
//        
//        return PartnersDataModel.init(logo: logo, company: company, field: field)
//    }
    /*func getDesc(key: String) -> String {
        return LanguageManager.shared.localized(string: key)!
    }*/

}
