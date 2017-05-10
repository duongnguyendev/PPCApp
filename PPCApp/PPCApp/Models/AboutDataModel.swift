//
//  AboutusDataModels.swift
//  PPCApp
//
//  Created by NguoiNb on 4/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class AboutDataModel
{
    var id:Int
    var image:String
    var parrentid:Int
    var createdat:String
    var updateat:String
    var showhome:Int
    var status:Int
    var title:String
    var content:String
    init(){
        id = 0
        image = ""
        parrentid = 0
        createdat = ""
        updateat = ""
        showhome = 0
        status = 0
        title = ""
        content = ""
        
    }
    init(json:JSON){
        self.id = json["id"].int ?? -1
        self.image = json["image"].string ?? ""
        self.parrentid = json["parrent_id"].int ?? -1
        self.createdat = json["created_at"].string ?? ""
        self.updateat = json["update_at"].string ?? ""
        self.showhome = json["show_home"].int ?? -1
        self.status = json["status"].int ?? -1
        self.title = json["title"].string ?? ""
        self.content = json["content"].string ?? ""
        
    }
    
}
