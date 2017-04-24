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
    
    @IBOutlet weak var bgrImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    var new = NewDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.numberOfLines = 2
    }
    override func viewDidAppear(_ animated: Bool) {
        title = new.title
        bgrImage.loadImageUsingUrlString(urlString: new.image)
        titleLabel.text = new.title
        new.content.htmlAttributedString(completion: { (mString) in
            contentTextView.attributedText = mString
        })
    }
    
}
