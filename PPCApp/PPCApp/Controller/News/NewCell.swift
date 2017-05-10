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
    @IBOutlet weak var newImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var new: NewDataModel?{
        didSet{
            //APIService.shared.getImage(url: (new?.image)!) { (image, error) in
                //self.newImage.image = image
            //}
            newImage.loadImageUsingUrlString(urlString: (new?.image)!)
            titleLabel.text = new?.title
            new?.content.htmlAttributedString(completion: { (mString) in
                contentLabel.attributedText = mString
            })
        }
    }
}
