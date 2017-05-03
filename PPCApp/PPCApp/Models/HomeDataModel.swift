//
//  SaleDataModel.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/13/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class HomeDataModel: NSObject{
    var id: Int
    var project_id: Int
    var country_id : Int
    var provine_id: Int
    var district_id: Int
    var type: Int
    var floor: Int
    var apartment: Int
    var bedroom: Int
    var bathroom: Int
    var acreage: Int
    var area_apartment: Float
    var sale: String
    var invoice: String
    var price: String
    var image: String
    var address: String
    var latitude: Float
    var longtitude: Float
    var phone: String
    var email: String
    var furniture: String
    var create_at: String
    var update_at: String
    var status: Int
    var image_overall: String
    var investor: String
    var id_user: Int
    var title: String
    var info: String
    var ownership: String
    var service: String
    var project: String
    var images: [String]
    override init() {
        id = -1
        project_id = -1
        country_id = -1
        provine_id = -1
        district_id = -1
        type =  -1
        floor = -1
        apartment = -1
        bedroom = -1
        bathroom = -1
        acreage = -1
        area_apartment = -1
        sale = ""
        invoice = ""
        price = ""
        image = ""
        address = ""
        latitude = -1
        longtitude = -1
        phone = ""
        email = ""
        furniture = ""
        create_at = ""
        update_at = ""
        status = -1
        image_overall = ""
        investor = ""
        id_user = -1
        title = ""
        info = ""
        ownership = ""
        service = ""
        images = []
        project = ""
    }
    init(json: JSON) {
        id = json["id"].int ?? -1
        project_id = json["project_id"].int ?? -1
        country_id = json["country_id"].int ?? -1
        provine_id = json["provine_id"].int ?? -1
        district_id = json["district_id"].int ?? -1
        type = json["type"].int ?? -1
        floor = json["floor"].int ?? -1
        apartment = json["apartment"].int ?? -1
        bedroom = json["bedroom"].int ?? -1
        bathroom = json["bathroom"].int ?? -1
        acreage = json["acreage"].int ?? -1
        area_apartment = json["area_apartment"].float ?? -1
        sale = json["sale"].string ?? ""
        invoice = json["invoice"].string ?? ""
        price = json["price"].string ?? ""
        image = json["image"].string ?? ""
        address = json["address"].string ?? ""
        latitude = json["latitude"].float ?? -1
        longtitude = json["longtitude"].float ?? -1
        phone = json["phone"].string ?? ""
        email = json["email"].string ?? ""
        furniture = json["furniture"].string ?? ""
        create_at = json["create_at"].string ?? ""
        update_at = json["update_at"].string ?? ""
        status = json["status"].int ?? -1
        image_overall = json["image_overall"].string ?? ""
        investor = json["investor"].string ?? ""
        id_user = json["id_user"].int ?? -1
        title = json["title"].string ?? ""
        info = json["info"].string ?? ""
        project = json["project"].string ?? ""
        ownership = json["ownership"].string ?? ""
        service = json["service"].string ?? ""
        images = json["images"].array?.map{ return String(describing: $0) } ?? []
    }
}
