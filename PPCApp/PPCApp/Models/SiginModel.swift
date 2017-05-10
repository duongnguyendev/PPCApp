//
//  SiginModel.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class SigninModel: NSObject {
    var id:Int
    var username: String
    var fullname: String
    var email: String
    var phone: String
    var avatar: String
    var address: String
    var password: String
    override init() {
        id = -1
        username = ""
        fullname = ""
        email = ""
        avatar = ""
        address = ""
        phone = ""
        password = ""
    }
    init(json: JSON) {
        self.id = json["id"].int ?? -1
        self.username = json["username"].string ?? ""
        self.fullname = json["fullname"].string ?? ""
        self.email = json["email"].string ?? ""
        self.address = json["address"].string ?? ""
        self.avatar = json["avatar"].string ?? ""
        self.phone = json["phone"].string ?? ""
        self.password = json["password"].string ?? ""
    }
    
}
