//
//  AboutusCell.swift
//  PPCApp
//
//  Created by NguoiNb on 4/17/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var about: AboutDataModel?{
        didSet{
            titleLabel.text = about?.title
            about?.content.htmlAttributedString(completion: { (mString) in
                contentLabel.attributedText = mString
            })

        }
    }
}
