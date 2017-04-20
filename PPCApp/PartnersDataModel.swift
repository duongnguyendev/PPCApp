//
//  Partners.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/29/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class PartnersDataModel: NSObject{
    let id:Int
    let image: String
    let link: String
    let name:String
    let status:String
    
    init(json:JSON) {

        self.id = json["id"].int ?? -1
        self.image = json["image"].string ?? ""
        self.link = json["link"].string ?? ""
        self.name = json["name"].string ?? ""
        self.status = json["status"].string ?? ""
     }
}
