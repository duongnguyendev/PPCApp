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
    let id: Int
    let project_id: Int
    let country_id : Int
    let provine_id: Int
    let district_id: Int
    let type: Int
    let floor: Int
    let apartment: Int
    let bedroom: Int
    let bathroom: Int
    let acreage: Int
    let area_apartment: Float
    let sale: String
    let invoice: String
    let price: String
    let image: String
    let address: String
    let latitude: Float
    let longtitude: Float
    let phone: String
    let email: String
    let furniture: String
    let create_at: String
    let update_at: String
    let status: Int
    let image_overall: String
    let investor: String
    let id_user: Int
    let title: String
    let info: String
    let ownership: String
    let service: String
    let images: [String]
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
        ownership = json["ownership"].string ?? ""
        service = json["service"].string ?? ""
        images = json["images"].array?.map{ return String(describing: $0) } ?? []
    }
}
