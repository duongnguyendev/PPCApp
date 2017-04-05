//
//  PMCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/5/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PMCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //deleteButton.layer.borderWidth = 2.0
        deleteButton.layer.borderColor = UIColor.rgb(red: 52, green: 34, blue: 20).cgColor
    }
    
    
}
