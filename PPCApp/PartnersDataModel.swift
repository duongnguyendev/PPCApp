//
//  Partners.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/29/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
class PartnersDataModel: NSObject{
    let logo: String
    let company: String
    let field: String
    
    init(logo: String,company: String,field: String) {
        self.logo = logo
        self.company = company
        self.field = field
    }
}
