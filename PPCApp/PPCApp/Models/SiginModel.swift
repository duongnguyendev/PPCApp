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
    let message:Int
    let id:Int
    let username: String
    let fullname: String
    let email: String
    let phone: String
    let avatar: String
   
    init() {
        message = -1
        id = -1
        username = ""
        fullname = ""
        email = ""
        avatar = ""
        phone = ""
    }
    init(message:Int,json:JSON) {
        self.message = message
        self.id = json["id"].int ?? -1
        self.username = json["username"].string ?? "loi"
        self.fullname = json["fullname"].string ?? "loi"
        self.email = json["email"].string ?? "loi"
        self.avatar = json["avatar"].string ?? "loi"
        self.phone = json["phone"].string ?? "loi"
    }
    func toDic(log:SigninModel)->Dictionary<String,Any>{
        let logs:Dictionary<String,Any> = ["id":log.id,"username":log.username,"fullname":log.fullname,"email":log.email,"avata":log.avatar,"phone":log.phone,"message":log.message]
        return logs
    }
}
