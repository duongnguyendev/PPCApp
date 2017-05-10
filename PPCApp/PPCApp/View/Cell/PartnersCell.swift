//
//  PartnersCell.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/29/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class PartnersCell: UITableViewCell {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var fieldLabel: UILabel!
    var partners: PartnersDataModel!{
        didSet{
            logoImage.loadImageurl(link: partners.image)
            companyLabel.text = partners.name
            fieldLabel.text = partners.link
        }
    }
}
