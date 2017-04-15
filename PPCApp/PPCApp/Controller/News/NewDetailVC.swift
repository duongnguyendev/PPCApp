//
//  DetailNewVC.swift
//  PPCApp
//
//  Created by Macbook Solution on 4/11/17.
//  Copyright © 2017 Nguyen Duy Duong. All rights reserved.
//

import Foundation
import UIKit
class NewDetailVC: BaseVC{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var bgrImage: UIImageView!
    
    var new = NewDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIService.shared.getImage(url: (new.image)) { (image, error) in
            self.bgrImage.image = image
        }
        titleLabel.text = new.title
        new.content.htmlAttributedString(completion: { (mString) in
            contentTextView.attributedText = mString
        })

    }
    
}
