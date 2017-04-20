//
//  SiginService.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class SiginService:BaseService{
    static let share = SiginService()
    func postSignin(parameters:[String:String],completion: @escaping (SigninModel)->Void){
        
//        let url = "http://api.perfectpropertyvn.com/user/login"
       //var signin = SigninModel()
//        apiService.posturl(url: url, parameters: parameters) { (jsons, err) in
//            if err == nil{
//                let json = jsons!["data"]
//                let sig = SigninModel(message: (jsons?["message"].int)!, json: json)
//                completion(sig)
//            }
//            else{
//                let sigdie = SigninModel()
//                completion(sigdie)
//                
//            }
//        }
        let url = "user/login"
        apiService.post(url: url, parameters: parameters) { (jsons, err) in
            if err == nil{
                                let json = jsons!["data"]
                                let sig = SigninModel(message: (jsons?["message"].int)!, json: json)
                                completion(sig)
                            }
                            else{
                                let sigdie = SigninModel()
                                completion(sigdie)
                                
                            }
        }
        
    
}
}
