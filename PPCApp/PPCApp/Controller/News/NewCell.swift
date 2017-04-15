//
//  newscell.swift
//  PPCApp
//
//  Created by Macbook Solution on 3/23/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import FontAwesome_swift
class NewCell: UITableViewCell{
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
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
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        contentLabel.numberOfLines = 3
        contentLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
    }
    var new: NewDataModel?{
        didSet{
            APIService.shared.getImage(url: (new?.image)!) { (image, error) in
                self.newImage.image = image
            }
            titleLabel.text = new?.title
            new?.content.htmlAttributedString(completion: { (mString) in
                contentLabel.attributedText = mString
            })
        }
    }
}
