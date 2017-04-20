//
//  AboutusCell.swift
//  PPCApp
//
//  Created by NguoiNb on 4/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class AboutusCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var contentLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var  aboutus:AboutusDataModels!{
        didSet{
            titleLabel.text = aboutus.title
            contentLable.text = aboutus.content
        }
    }
}
