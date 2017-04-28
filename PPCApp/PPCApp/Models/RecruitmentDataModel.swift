//
//  RecruitmentDataModel.swift
//  PPCApp
//
//  Created by NguoiNb on 4/14/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import SwiftyJSON
class RecruitmentDataModel:NSObject{
    let id: Int
    let image: String
    let deadline: String
    let status: String
    let title: String
    let content:String
    override init(){
        self.id = 0
        self.image = ""
        self.deadline = ""
        self.status = ""
        self.title = ""
        self.content = ""
        
    }
    init(json:JSON){
        self.id = json["id"].int ?? -1
        self.image = json["image"].string ?? " "
        self.deadline = json["deadline"].string ?? ""
        self.status = json["status"].string ?? " "
        self.title = json["title"].string ?? " "
        self.content = json["content"].string ?? " "
        
        
    }
    
    
    
}
