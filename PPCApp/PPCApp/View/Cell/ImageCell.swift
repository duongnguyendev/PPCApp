//
//  ImageCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/18/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class ImageCell: BaseCell{
    let detailImage : CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    override func setupView() {
        addSubview(detailImage)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: detailImage)
        addConstraintWithFormat(format: "V:|[v0]|", views: detailImage)
    }
    
}
