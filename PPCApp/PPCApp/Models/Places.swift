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
    //var index : Int?
    let id : NSNumber?
    let name : String?
    init(id : NSNumber, name : String) {
        self.id = id
        self.name = name
    }
}
