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
    
    /*override func layoutSubviews() {
        super.layoutSubviews()
        newImage.translatesAutoresizingMaskIntoConstraints = false
    }*/
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
        //titleLabel.numberOfLines = 3
        //newImage.frame.size = CGSize(width: 50.0, height: 50.0)
        //newImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        //newImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 9 / 16).isActive = true
        let screenSize: CGRect = UIScreen.main.bounds
        newImage.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.width)
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        descLabel.numberOfLines = 3
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        
        newImage.image = UIImage(named: "home.jpeg")
        titleLabel.text = "SEASONS AVANUE"
        descLabel.text = "VinHomes Skylake owns the gold position on Pham Hung streets"
            + "crosses with Duong Dinh Nghe Street,opposite to Cau Giay lake."
            + "The project covers an areas of 32 hectater,in-cluding 19 hectater"
            + "of water surface,statisfying the criteria of occupational status,"
            + "choosing the place of living"
    }
    
    var new: NewDataModel!{
        didSet{
            newImage.image = UIImage(named: "home.jpeg")
            titleLabel.text = "SEASONS AVANUE"
            descLabel.text = "VinHomes Skylake owns the gold position on Pham Hung streets"
                            + "crosses with Duong Dinh Nghe Street,opposite to Cau Giay lake."
                            + "The project covers an areas of 32 hectater,in-cluding 19 hectater"
                            + "of water surface,statisfying the criteria of occupational status,"
                            + "choosing the place of living"
        }
    }
    
}
