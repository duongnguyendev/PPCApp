//
//  TermsModel.swift
//  PPCApp
//
//  Created by NguoiNb on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class TermsModel:AnyObject{
    let id:Int
    let title:String
    let content:String
    init() {
        id = -1
        title = ""
        content = ""
        
    }
    init(json:JSON) {
        self.id = json["id"].int ?? -1
        self.title = json["title"].string ?? "loi"
        self.content = json["content"].string ?? "loi"
    }
}
