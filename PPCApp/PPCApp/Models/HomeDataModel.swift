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
    var project_id: NSNumber
    var country_id : NSNumber
    var provine_id: NSNumber
    var district_id: NSNumber
    var type: Int
    var floor: Int
    var apartment: Int
    var bedroom: Int
    var bathroom: Int
    var acreage: Int
    var area_apartment: Int
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
    var langEN: Int?
    var langVI: Int?
    var lang: String?
    var fileImage: Data?
    var fileImage_overall: Data?
    var fileMultiImage: [Data]?
    
    var country: String
    var province: String
    var district: String
    override init() {
        id = 0
        project_id = 0
        country_id = 0
        provine_id = 0
        district_id = 0
        type =  0
        floor = 0
        apartment = 0
        bedroom = 0
        bathroom = 0
        acreage = 0
        area_apartment = 0
        sale = ""
        invoice = ""
        price = ""
        image = ""
        address = ""
        latitude = 0
        longtitude = 0
        phone = ""
        email = ""
        furniture = ""
        create_at = ""
        update_at = ""
        status = 0
        image_overall = ""
        investor = ""
        id_user = 0
        title = ""
        info = ""
        ownership = ""
        service = ""
        images = []
        project = ""
        
        langEN = 0
        langVI = 0
        fileImage = nil
        fileImage_overall = nil
        fileMultiImage = nil
        
        country = ""
        province = ""
        district = ""
        lang = ""
    }
    init(json: JSON) {
        id = json["id"].int ?? 0
        project_id = json["project_id"].number ?? 0
        country_id = json["country_id"].number ?? 0
        provine_id = json["province_id"].number ?? 0
        district_id = json["district_id"].number ?? 0
        country = json["country"].string ?? ""
        province = json["province"].string ?? ""
        district = json["district"].string ?? ""
        project = json["project"].string ?? ""

        type = json["type"].int ?? -1
        floor = json["floor"].int ?? -1
        apartment = json["apartment"].int ?? -1
        bedroom = json["bedroom"].int ?? -1
        bathroom = json["bathroom"].int ?? -1
        acreage = json["acreage"].int ?? -1
        area_apartment = json["area_apartment"].int ?? 0
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
        ownership = json["ownership"].string ?? ""
        service = json["service"].string ?? ""
        images = json["images"].array?.map{ return String(describing: $0) } ?? []
        lang = json["lang"].string ?? ""
        langEN = 0
        langVI = 0
    }
}
