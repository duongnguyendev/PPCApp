//
//  Places.swift
//  PPCApp
//
//  Created by Nguyen Duy Duong on 4/4/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class Place: NSObject {
    var index : Int?
    var id : NSNumber?
    var name : String?
    init(id : NSNumber, name : String) {
        self.id = id
        self.name = name
    }
    init(json: JSON) {
        self.id = json["id"].number ?? -1
        self.name = json["name"].string ?? ""
    }
}
