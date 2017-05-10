//
//  NewDataModel.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class NewDataModel: NSObject{
    let id:Int
    let id_category:Int
    let image:String
    let type:String
    let created_at:String
    let updated_at:String
    let status:Int
    let slug:String
    let lang: String
    let new_id: Int
    let title:String
    let content: String
    
    override init() {
        id = -1
        id_category = -1
        image = ""
        type = ""
        created_at = ""
        updated_at = ""
        status = -1
        slug = ""
        lang = ""
        new_id = -1
        title = ""
        content = ""
    }
    init(json: JSON) {
        id = json["id"].int ?? -1
        id_category = json["id_category"].int ?? -1
        image = json["image"].string ?? ""
        type = json["type"].string ?? ""
        created_at = json["created_at"].string ?? ""
        updated_at = json["updated_at"].string ?? ""
        status = json["status"].int ?? -1
        slug = json["slug"].string ?? ""
        lang = json["lang"].string ?? ""
        new_id = json["new_id"].int ?? -1
        title = json["title"].string ?? ""
        content = json["content"].string ?? ""
    }
    
}
