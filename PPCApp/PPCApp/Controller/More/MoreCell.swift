//
//  MoreCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/27/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class MoreCell: UITableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var more: MoreDataModel!{
        didSet{
            descLabel.text = more.desc
            iconImage.image = UIImage(named: more.icon)
        }
    }
}
