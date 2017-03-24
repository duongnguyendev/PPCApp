//
//  newscell.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
class NewCell: UITableViewCell {
   
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var heightImage:CGFloat = 0.0
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        newImage.translatesAutoresizingMaskIntoConstraints = false
        //Initialization code
        //titleLabel.numberOfLines = 3
        //newImage.frame.size = CGSize(width: 50.0, height: 50.0)
        //newImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        descLabel.text = "VinHomes Skylake owns the gold position on Pham Hung street"
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        //newImage.heightAnchor.constraint(equalToConstant: heightImage * 9/16).isActive = true
    }
    
    var new: NewDataModel!{
        didSet{
//            self.newImage = UIImageView(image: UIImage(named: "home.jpeg"))
            newImage.heightAnchor.constraint(equalToConstant: heightImage * 9/16).isActive = true
            newImage.image = UIImage(named: "home.jpeg")
            //titleLabel.text = new.title
        }
    }
    
}
