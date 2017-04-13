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
    let per_page: Int
    let current_page: Int
    let next_page_url: String
    let prev_page_url: String
    let from: Int
    let to: Int
    let datas: [Datas]
    init(json: JSON) {
        per_page = json["per_page"].int ?? -1
        current_page = json["current_page"].int ?? -1
        next_page_url = json["next_page_url"].string ?? ""
        prev_page_url = json["prev_page_url"].string ?? ""
        from = json["from"].int ?? -1
        to = json["to"].int ?? -1
        datas = json["data"].array?.map { return Datas(json: $0) } ?? []
    }
}
class Datas: NSObject{
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
