//
//  NewDataModel.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class NewDataModel: NSObject {
    
    let id:Int
    let id_category:Int
    let image:String
    let type:String
    let created_at:String
    let updated_at:String
    let status:Int
    let slug:String
    let title:String
    
    init(json: JSON) {
        id = json["id"].int ?? -1
        id_category = json["id_category"].int ?? -1
        image = json["image"].string ?? ""
        type = json["type"].string ?? ""
        created_at = json["created_at"].string ?? ""
        updated_at = json["updated_at"].string ?? ""
        status = json["status"].int ?? -1
        slug = json["slug"].string ?? ""
        title = json["title"].string ?? ""
    }

}
