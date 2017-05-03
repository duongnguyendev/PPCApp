//
//  PostFileDataModel.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/28/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PostDataModel: HomeDataModel{
    var langVI: Int?
    var langEN: Int?
    var fileImage: Data?
    var fileImage_overload: Data?
    var fileMultiImage: [Data]?
    
    override init(){
        super.init()
        self.langVI = nil
        self.langEN = nil
        self.fileImage = nil
        self.fileImage_overload = nil
        self.fileMultiImage = nil
    }
    
}
