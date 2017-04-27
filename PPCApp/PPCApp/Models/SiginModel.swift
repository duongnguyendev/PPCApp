//
//  SiginModel.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class SigninModel: AnyObject {
    var message:Int
    var id:Int
    var username: String
    var fullname: String
    var email: String
    var phone: String
    var avatar: String
    var address:String
   
    init() {
        message = -1
        id = -1
        username = ""
        fullname = ""
        email = ""
        avatar = ""
        phone = ""
        address = ""
    }
    init(message:Int,json:JSON) {
        self.message = message
        self.id = json["id"].int ?? -1
        self.username = json["username"].string ?? "loi"
        self.fullname = json["fullname"].string ?? "loi"
        self.email = json["email"].string ?? "loi"
        self.avatar = json["avatar"].string ?? "loi"
        self.phone = json["phone"].string ?? "loi"
        self.address = json["address"].string ?? "loi"
    }
    init(dic:Dictionary<String,Any>){
        self.id = dic["id"] as! Int
        self.address = dic["address"] as! String
        self.avatar = dic["avatar"] as! String
        self.email = dic["email"] as! String
        self.fullname = dic["fullname"] as! String
        self.message = dic["message"] as! Int
        self.username = dic["username"] as! String
        self.phone = dic["phone"] as! String
        
        
    }
    init(message:Int,dic:Dictionary<String,Any>){
        self.id = dic["id"] as! Int
        self.address = dic["address"] as! String
        self.avatar = dic["avatar"] as! String
        self.email = dic["email"] as! String
        self.fullname = dic["fullname"] as! String
        self.message = message
        self.username = dic["username"] as! String
        self.phone = dic["phone"] as! String

    }
    func toDic(log:SigninModel)->Dictionary<String,Any>{
        let logs:Dictionary<String,Any> = ["id":log.id,"username":log.username,"fullname":log.fullname,"email":log.email,"avatar":log.avatar,"phone":log.phone,"message":log.message,"address":log.address]
        return logs
    }
}
