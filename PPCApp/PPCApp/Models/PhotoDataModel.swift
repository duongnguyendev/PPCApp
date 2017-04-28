//
//  PhotoDataModel.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PhotoDataModel: NSObject{
    
    let id: Int
    let image: UIImage!
    
    init(id: Int,image: UIImage) {
        self.id = id
        self.image = image
    }
}
