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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
        companyLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightMedium)
        fieldLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
    }
    var partners: PartnersDataModel!{
        didSet{
            logoImage.image = UIImage(named: partners.logo)
            companyLabel.text = partners.company
            fieldLabel.text = partners.field
        }
    }
}
